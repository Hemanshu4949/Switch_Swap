import 'dart:async';
import 'package:flutter/services.dart';
import 'package:volume_controller/volume_controller.dart';
import '../engine/hardware_listener.dart';
import '../engine/trigger_matcher_service.dart';

class UIKeyCaptureService {
  static final UIKeyCaptureService _instance = UIKeyCaptureService._internal();
  factory UIKeyCaptureService() => _instance;
  UIKeyCaptureService._internal();

  Function(dynamic)? _callback;
  StreamSubscription<HardwareEvent>? _hardwareSubscription;
  
  StreamSubscription<double>? _volumeSubscription;
  double _currentVolume = 0.5;
  double _originalVolume = 0.5; // Store the user's real volume
  bool _isInitializingVolume = false; // Flag to ignore the initial 50% setup event
  final Map<dynamic, DateTime> _lastEventTimes = {};

  void _debouncedCallback(dynamic key) {
    final now = DateTime.now();
    final lastEventTime = _lastEventTimes[key];
    
    // 300ms debounce PER KEY. 
    // This prevents double-triggers from holding a single button too long, 
    // but instantly accepts if you press a DIFFERENT button!
    if (lastEventTime == null || now.difference(lastEventTime).inMilliseconds > 300) {
      _lastEventTimes[key] = now;
      if (_callback != null) {
        _callback!(key);
      }
    }
  }

  void startCapture({
    required bool isAccessibilityEnabled,
    required bool isPhoneSource,
    required Function(dynamic) callback,
  }) {
    // PAUSE BACKGROUND ENGINE
    TriggerMatcherService.instance?.stop();
    
    _callback = callback;
    
    // 1. ALWAYS ENABLE FLUTTER NATIVE LISTENER (HardwareKeyboard) 
    // This catches standard keyboard/gamepad events natively.
    HardwareKeyboard.instance.addHandler(_flutterKeyHandler);

    if (isAccessibilityEnabled) {
      // 2A. KOTLIN NATIVE LISTENER (Via HardwareListener Stream)
      // When Accessibility is ON, we rely on the native Android layer to push Volume/Headset events safely.
      _hardwareSubscription = HardwareListener.onKeyEvent.listen((event) {
        if (event.isDown) {
          _debouncedCallback(event.keyCode);
        }
      });
    } else {
      // 2B. FLUTTER FALLBACK LISTENER (VolumeController Hack)
      // When Accessibility is OFF, we use the volume stream to listen for phone volume keys.
      if (isPhoneSource) {
        VolumeController.instance.showSystemUI = false; // Bypass OS UI
        _isInitializingVolume = true;
        
        // Save the user's real volume, then force it to exactly 50%
        // If we don't do this, pressing 'Volume Up' when already at 100% won't trigger the listener!
        VolumeController.instance.getVolume().then((volume) {
          _originalVolume = volume;
          VolumeController.instance.setVolume(0.5);
          _currentVolume = 0.5;
          
          // Give the OS a half second to process the programmatic volume change 
          // before we start actually recording inputs
          Future.delayed(const Duration(milliseconds: 500), () {
            _isInitializingVolume = false;
          });
        });

        _volumeSubscription = VolumeController.instance.addListener((volume) {
            if (_isInitializingVolume) return; // Ignore the ghost event

            // Ignore tiny floating point fluctuations
            if ((volume - _currentVolume).abs() > 0.01) {
              if (volume > _currentVolume) {
                _debouncedCallback(24); // 24 = Volume Up
              } else if (volume < _currentVolume) {
                _debouncedCallback(25); // 25 = Volume Down
              }
              
              // We must temporarily block the listener while we reset to 50%
              // to prevent an infinite feedback loop of ghost inputs.
              _isInitializingVolume = true;
              VolumeController.instance.setVolume(0.5);
              Future.delayed(const Duration(milliseconds: 50), () {
                 _isInitializingVolume = false;
              });
            }
        });
      }
    }
  }

  void stopCapture() {
    _callback = null;
    _hardwareSubscription?.cancel();
    _hardwareSubscription = null;
    HardwareKeyboard.instance.removeHandler(_flutterKeyHandler);
    
    _volumeSubscription?.cancel();
    _volumeSubscription = null;
    
    // Restore the user's original volume gracefully
    VolumeController.instance.setVolume(_originalVolume);
    VolumeController.instance.showSystemUI = true;
    
    // RESUME BACKGROUND ENGINE
    TriggerMatcherService.instance?.start();
  }

  bool _flutterKeyHandler(KeyEvent event) {
    if (event is KeyDownEvent) {
      _debouncedCallback(event.logicalKey);
      return true; // Consume
    }
    return false;
  }
}

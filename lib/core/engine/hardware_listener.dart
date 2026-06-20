import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart'; // Needed for debugPrint

class HardwareEvent {
  final int keyCode;
  final bool isDown;

  HardwareEvent({required this.keyCode, required this.isDown});
}

class HardwareListener {
  // 1. The exact channel name matching your Kotlin code
  static const MethodChannel _channel = MethodChannel('com.example.switch_swap/actions');

  static final StreamController<HardwareEvent> _keyEventController = StreamController<HardwareEvent>.broadcast();
  static final StreamController<bool> _statusController = StreamController<bool>.broadcast();

  static bool _isListening = false;
  static bool get isListening => _isListening;

  static Stream<HardwareEvent> get onKeyEvent => _keyEventController.stream;
  static Stream<bool> get onStatusChanged => _statusController.stream;

  static void init() {
    debugPrint("HardwareListener initialized. Binding to Kotlin MethodChannel...");

    // 2. Attach the permanent listener to the Android OS
    _channel.setMethodCallHandler((call) async {

      // 🔔 THE DART DOORBELL TRAP
      debugPrint("🔔 DART DOORBELL RANG! Method requested: ${call.method} | Args: ${call.arguments}");

      if (!_isListening) {
        debugPrint("HardwareListener: Ignored event because isListening = false");
        return;
      }

      // 3. Catch the specific hardware event broadcasted by Kotlin
      if (call.method == "onHardwareEvent") {
        final args = call.arguments as Map<dynamic, dynamic>?;

        if (args != null && args.containsKey('keyCode')) {
          final int keyCode = args['keyCode'] as int;
          // If native doesn't pass 'isDown', assume true for now
          final bool isDown = args['isDown'] as bool? ?? true;

          // 4. Pipe the real native event into your Dart stream!
          _keyEventController.add(HardwareEvent(keyCode: keyCode, isDown: isDown));
          debugPrint("HardwareListener: Successfully piped KeyCode $keyCode to the rest of the app.");
        }
      }
    });

    startListening();
  }

  static void startListening() {
    if (!_isListening) {
      _isListening = true;
      _statusController.add(true);
      debugPrint("HardwareListener: Started listening for events.");
    }
  }

  static void stopListening() {
    if (_isListening) {
      _isListening = false;
      _statusController.add(false);
      debugPrint("HardwareListener: Stopped listening for events.");
    }
  }
}
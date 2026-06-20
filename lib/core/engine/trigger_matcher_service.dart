import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';

import '../model/automation_profile.dart';
import '../execution/action_executor.dart';
import 'hardware_listener.dart';

class TriggerMatcherService {
  static TriggerMatcherService? instance;
  
  final Isar isar;
  StreamSubscription<HardwareEvent>? _subscription;
  final StreamController<bool> _statusController = StreamController<bool>.broadcast();

  bool _isActive = false;
  bool get isActive => _isActive;
  Stream<bool> get onStatusChanged => _statusController.stream;

  // 1. State Management Buffers
  final List<String> _keyBuffer = [];
  final List<int> _rawCodeBuffer = [];
  List<AutomationProfile> _shortlistedProfiles = [];
  Timer? _debounceTimer;

  TriggerMatcherService(this.isar) {
    instance = this;
  }

  void start() {
    if (!_isActive) {
      print("TriggerMatcherService: Starting to listen for hardware events...");
      _subscription = HardwareListener.onKeyEvent.listen(_evaluateEvent);
      _isActive = true;
      _statusController.add(true);
    }
  }

  void stop() {
    if (_isActive) {
      print("TriggerMatcherService: Stopping listener...");
      _subscription?.cancel();
      _debounceTimer?.cancel();
      _keyBuffer.clear();
      _rawCodeBuffer.clear();
      _shortlistedProfiles.clear();
      _isActive = false;
      _statusController.add(false);
    }
  }

  String _mapKeyCodeToName(int keyCode) {
    switch (keyCode) {
      case 24: return 'Volume Up';
      case 25: return 'Volume Down';
      case 26: return 'Power';
      case 85: return 'Media Play/Pause';
      case 79: return 'Headset Hook';
      default: return keyCode.toString();
    }
  }

  // 2. The Listener (On Key Received)
  Future<void> _evaluateEvent(HardwareEvent event) async {
    // We only buffer the key DOWN events
    if (!event.isDown) return;

    final keyCodeStr = _mapKeyCodeToName(event.keyCode);
    
    // Add to buffers
    _keyBuffer.add(keyCodeStr);
    _rawCodeBuffer.add(event.keyCode);

    debugPrint("SwitchSwap-Brain: 1. KEY RECEIVED - Added $keyCodeStr to buffer. Buffer is now $_keyBuffer");

    try {
      // The Isar Fetch (First Key Only)
      if (_keyBuffer.length == 1) {
        _shortlistedProfiles = await isar.automationProfiles
            .filter()
            .isEnabledEqualTo(true)
            .findAll();
      }

      // The Real-Time Filter (RAM)
      // Keep ONLY profiles where the triggerSequence starts with the exact elements currently in _keyBuffer
      _shortlistedProfiles = _shortlistedProfiles.where((profile) {
        final sequence = profile.triggerSequence;
        if (sequence.length < _keyBuffer.length) return false;
        
        for (int i = 0; i < _keyBuffer.length; i++) {
          if (sequence[i] != _keyBuffer[i]) {
            return false;
          }
        }
        return true;
      }).toList();

      if (_shortlistedProfiles.isEmpty) {
        debugPrint("SwitchSwap-Brain: 2. NO POSSIBLE MACROS - Instantly flushing buffer to OS without 300ms wait.");
        _evaluateBuffer();
        return;
      }

      // The Strict Debounce
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 300), _evaluateBuffer);
      debugPrint("SwitchSwap-Brain: 2. TIMER STARTED - Waiting 300ms...");

    } catch (e, stack) {
      print("TriggerMatcherService: Exception during real-time filtering: $e\n$stack");
    }
  }

  // 3. The Evaluation
  Future<void> _evaluateBuffer() async {
    // Snapshot the state
    final stringSnapshot = List<String>.from(_keyBuffer);
    final rawSnapshot = List<int>.from(_rawCodeBuffer);
    final candidates = List<AutomationProfile>.from(_shortlistedProfiles);

    // Immediately clear buffers for the next sequence
    _keyBuffer.clear();
    _rawCodeBuffer.clear();
    _shortlistedProfiles.clear();

    debugPrint("SwitchSwap-Brain: 3. TIMER EXPIRED - Evaluating Buffer: $stringSnapshot");

    // ==========================================
    // 🔍 ENGINE DIAGNOSTIC X-RAY
    // ==========================================
    try {
      final allProfiles = await isar.automationProfiles.where().findAll();
      debugPrint("\n====== 🔍 TRIGGER ENGINE X-RAY ======");
      debugPrint("LIVE INPUT BUFFER : '${stringSnapshot.join("', '")}'");
      
      for (var p in allProfiles) {
        final seqStr = p.triggerSequence.map((s) => "'$s'").join(", ");
        final isExactMatch = listEquals(p.triggerSequence, stringSnapshot);
        debugPrint("DATABASE PROFILE  : [${p.name}] -> Sequence: [$seqStr] | Enabled: ${p.isEnabled} | Exact Match: $isExactMatch");
      }
      debugPrint("=====================================\n");
    } catch (e) {
      debugPrint("X-Ray Error: $e");
    }
    // ==========================================

    // Find the Exact Match
    AutomationProfile? exactMatch;
    for (var profile in candidates) {
      if (profile.triggerSequence.length == stringSnapshot.length) {
        exactMatch = profile;
        break; // Found our exact match
      }
    }

    if (exactMatch != null) {
      // Path A (Match Found)
      debugPrint("SwitchSwap-Brain: 4A. MATCH FOUND! - Executing macro for profile: ${exactMatch.name}");
      print("TriggerMatcherService: Matched exact sequence to profile '${exactMatch.name}'");
      
      if (_evaluateConstraints(exactMatch.constraints)) {
        await exactMatch.macro.load();
        
        if (exactMatch.macro.value != null) {
          print("TriggerMatcherService: Triggering ActionExecutor...");
          // Execute the matched macro
          await ActionExecutor.execute(exactMatch, null);
        } else {
          print("TriggerMatcherService: Profile matched but no macro was linked.");
        }
      } else {
        print("TriggerMatcherService: Execution blocked by constraints.");
      }
    } else {
      // Path B (No Match Found)
      debugPrint("SwitchSwap-Brain: 4B. NO MATCH - Firing passthrough to Kotlin with raw codes: $rawSnapshot");
      print("TriggerMatcherService: No match found. Passing raw buffer to Kotlin.");
      try {
        const channel = MethodChannel('com.example.switch_swap/actions');
        await channel.invokeMethod('passthrough_keys', {'keyCodes': rawSnapshot});
      } on PlatformException catch (e) {
        print("TriggerMatcherService: Failed to passthrough keys: ${e.message}");
      }
    }
  }

  bool _evaluateConstraints(ExecutionConstraints? constraints) {
    if (constraints == null) return true;
    
    // TODO: Implement Constraint Checks (Screen off, specific app foregrounded, etc.)
    return true;
  }
}

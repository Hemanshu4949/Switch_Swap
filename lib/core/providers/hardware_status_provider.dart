import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../engine/hardware_listener.dart';
import '../engine/trigger_matcher_service.dart';

/// Provides the current active status of the underlying HardwareListener.
final hardwareListenerStatusProvider = StreamProvider<bool>((ref) async* {
  yield HardwareListener.isListening;
  yield* HardwareListener.onStatusChanged;
});

/// Provides the current active status of the TriggerMatcherService.
final triggerMatcherStatusProvider = StreamProvider<bool>((ref) async* {
  if (TriggerMatcherService.instance != null) {
    yield TriggerMatcherService.instance!.isActive;
    yield* TriggerMatcherService.instance!.onStatusChanged;
  } else {
    yield false;
  }
});

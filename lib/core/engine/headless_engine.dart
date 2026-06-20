import 'package:flutter/material.dart';
import '../services/isar_service.dart';
import 'hardware_listener.dart';
import 'trigger_matcher_service.dart';

@pragma('vm:entry-point')
void headlessTask() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint("SwitchSwap-Headless: Headless Engine Booting...");
  
  try {
    // 1. Initialize databases in the background isolate
    final isarService = IsarService();
    final isarInstance = await isarService.db;
    
    // 2. Wake up the listeners and the brain
    HardwareListener.init();
    final triggerMatcher = TriggerMatcherService(isarInstance);
    triggerMatcher.start();
    
    debugPrint("SwitchSwap-Headless: Engine Online and Listening.");
  } catch (e, stack) {
    debugPrint("SwitchSwap-Headless: CRITICAL BOOT FAILURE: $e\n$stack");
  }
}

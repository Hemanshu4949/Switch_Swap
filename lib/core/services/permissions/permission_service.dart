import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'standard_permission_manager.dart';
import 'system_permission_manager.dart';

class PermissionService {
  final StandardPermissionManager _standardPermissionManager;
  final SystemPermissionManager _systemPermissionManager;

  PermissionService(
      this._standardPermissionManager, this._systemPermissionManager);

  // High-level utility methods
  Future<bool> hasCoreRunningPermissions() async {
    final hasNotification =
        await _standardPermissionManager.checkNotificationPermission();
    final hasBattery =
        await _standardPermissionManager.checkBatteryOptimizationExemption();
    return hasNotification && hasBattery;
  }

  Future<bool> hasAutomationPermissions() async {
    return await _systemPermissionManager.isAccessibilityServiceEnabled();
  }

  Future<bool> hasSystemAlertWindowGranted() async {
    return await _systemPermissionManager.isSystemAlertWindowGranted();
  }

  // Pass-through execution wrappers for Standard Permissions
  Future<bool> triggerNotificationRequest() async {
    return await _standardPermissionManager.requestNotificationPermission();
  }

  Future<bool> triggerBatteryOptimizationRequest() async {
    return await _standardPermissionManager
        .requestBatteryOptimizationExemption();
  }

  // Pass-through execution wrappers for System Permissions
  Future<bool> triggerAccessibilityPrompt() async {
    return await _systemPermissionManager.openAccessibilitySettings();
  }

  Future<bool> triggerSystemAlertWindowPrompt() async {
    return await _systemPermissionManager.openSystemAlertWindowSettings();
  }
}

// Global Provider for the Unified Facade
final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionService(
    StandardPermissionManager(),
    SystemPermissionManager(),
  );
});

// StreamProvider for UI wizard to reactively track accessibility changes
final accessibilityStatusStreamProvider = StreamProvider.autoDispose<bool>((ref) async* {
  final permissionService = ref.read(permissionServiceProvider);
  
  // Yield initial state
  yield await permissionService.hasAutomationPermissions();

  // Periodically check the status (e.g., every 1 second)
  final stream = Stream.periodic(const Duration(seconds: 1), (_) async {
    return await permissionService.hasAutomationPermissions();
  }).asyncMap((event) => event);

  // Yield stream updates
  await for (final status in stream) {
    yield status;
  }
});

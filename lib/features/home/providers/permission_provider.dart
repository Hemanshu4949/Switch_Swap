import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/engine/permission_service.dart';

class AccessibilityPermissionNotifier extends Notifier<bool> with WidgetsBindingObserver {
  @override
  bool build() {
    WidgetsBinding.instance.addObserver(this);
    
    // Defer the initial check until after the build phase
    Future.microtask(() => checkPermission());
    
    // Clean up the observer when the provider is disposed
    ref.onDispose(() {
      WidgetsBinding.instance.removeObserver(this);
    });

    return true; // Default to true initially to prevent flickering; checkPermission will update it.
  }

  Future<void> checkPermission() async {
    final isEnabled = await PermissionService.isAccessibilityEnabled();
    state = isEnabled;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appState) {
    if (appState == AppLifecycleState.resumed) {
      // Add a small delay to allow the OS time to bind the service instance
      // before we poll it from the native side.
      Future.delayed(const Duration(milliseconds: 500), () async {
        await checkPermission();
        // If it's still false, Android might be taking a little longer to boot the service.
        // Retry one more time after 1 second.
        if (!state) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            checkPermission();
          });
        }
      });
    }
  }
}

final accessibilityPermissionProvider = NotifierProvider<AccessibilityPermissionNotifier, bool>(() {
  return AccessibilityPermissionNotifier();
});

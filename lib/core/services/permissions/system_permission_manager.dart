import 'package:flutter/services.dart';

class SystemPermissionManager {
  static const MethodChannel _platform = MethodChannel('com.example.switch_swap/permissions');

  Future<bool> isAccessibilityServiceEnabled() async {
    try {
      final bool result = await _platform.invokeMethod('isAccessibilityEnabled');
      return result;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> openAccessibilitySettings() async {
    try {
      await _platform.invokeMethod('openAccessibilitySettings');
      return true;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> isSystemAlertWindowGranted() async {
    try {
      final bool result = await _platform.invokeMethod('isOverlayEnabled');
      return result;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> openSystemAlertWindowSettings() async {
    try {
      await _platform.invokeMethod('openOverlaySettings');
      return true;
    } on PlatformException {
      return false;
    }
  }
}

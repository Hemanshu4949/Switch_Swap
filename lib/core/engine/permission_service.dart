import 'package:flutter/services.dart';

class PermissionService {
  static const MethodChannel _channel = MethodChannel('com.example.switch_swap/permissions');

  static Future<bool> isAccessibilityEnabled() async {
    try {
      final bool isEnabled = await _channel.invokeMethod<bool>('isAccessibilityEnabled') ?? false;
      return isEnabled;
    } on PlatformException catch (e) {
      print("Failed to check accessibility: '${e.message}'.");
      return false;
    } catch (e) {
      print("Error checking accessibility (ensure native code is recompiled!): $e");
      return false;
    }
  }

  static Future<void> openAccessibilitySettings() async {
    try {
      await _channel.invokeMethod('openAccessibilitySettings');
    } on PlatformException catch (e) {
      print("Failed to open accessibility settings: '${e.message}'.");
    } catch (e) {
      print("Error opening settings (ensure native code is recompiled!): $e");
    }
  }
}

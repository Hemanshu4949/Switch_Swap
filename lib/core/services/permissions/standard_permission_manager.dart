import 'package:permission_handler/permission_handler.dart';

class StandardPermissionManager {
  Future<bool> checkNotificationPermission() async {
    return await Permission.notification.isGranted;
  }

  Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  Future<bool> checkBatteryOptimizationExemption() async {
    return await Permission.ignoreBatteryOptimizations.isGranted;
  }

  Future<bool> requestBatteryOptimizationExemption() async {
    final status = await Permission.ignoreBatteryOptimizations.request();
    return status.isGranted;
  }
}

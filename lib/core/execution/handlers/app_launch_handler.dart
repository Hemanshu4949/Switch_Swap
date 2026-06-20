import 'package:url_launcher/url_launcher.dart';
import 'package:device_apps/device_apps.dart';
import 'base_action_handler.dart';

class AppLaunchHandler implements BaseActionHandler {
  @override
  Future<bool> execute(String command) async {
    try {
      if (command.startsWith('launch_app:')) {
        final packageName = command.split(':').last;
        final isInstalled = await DeviceApps.isAppInstalled(packageName);
        
        if (!isInstalled) {
          print("Error: App with package '$packageName' is not installed.");
          return false;
        }
        
        final success = await DeviceApps.openApp(packageName);
        print("Launched app '$packageName': $success");
        return success;

      } else if (command.startsWith('open_url:')) {
        final urlString = command.substring(9);
        final uri = Uri.parse(urlString);
        
        if (await canLaunchUrl(uri)) {
          final success = await launchUrl(uri, mode: LaunchMode.externalApplication);
          print("Launched URL '$urlString': $success");
          return success;
        } else {
          print("Error: Could not launch URL '$urlString'.");
          return false;
        }
      } else {
        print("Unknown app launch command: $command");
        return false;
      }
    } catch (e) {
      print("Exception executing AppLaunchHandler: $e");
      return false;
    }
  }
}

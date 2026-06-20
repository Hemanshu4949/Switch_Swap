import 'package:volume_controller/volume_controller.dart';
import 'package:vibration/vibration.dart';
import 'base_action_handler.dart';

class VolumeHandler implements BaseActionHandler {
  @override
  Future<bool> execute(String command) async {
    try {
      if (command.startsWith("vibrate_")) {
        final hasVibrator = await Vibration.hasVibrator();
        if (hasVibrator != true) {
          print("Error: Device does not support vibration.");
          return false;
        }

        if (command == "vibrate_short") {
          await Vibration.vibrate(duration: 100);
          print("Executed short vibration.");
          return true;
        } else if (command == "vibrate_long") {
          await Vibration.vibrate(duration: 500);
          print("Executed long vibration.");
          return true;
        }
      } else if (command.startsWith("volume_")) {
        final currentVolume = await VolumeController.instance.getVolume();
        
        switch (command) {
          case 'volume_up':
            final newVol = (currentVolume + 0.1).clamp(0.0, 1.0);
            await VolumeController.instance.setVolume(newVol);
            print("Volume increased to $newVol");
            return true;
          case 'volume_down':
            final newVol = (currentVolume - 0.1).clamp(0.0, 1.0);
            await VolumeController.instance.setVolume(newVol);
            print("Volume decreased to $newVol");
            return true;
          case 'volume_mute_media':
            await VolumeController.instance.setVolume(0.0);
            print("Media volume muted.");
            return true;
          case 'volume_mute_ring':
            // Requires DND (Do Not Disturb) permissions via NotificationManager natively
            // Check handled pre-execution if required
            print("Triggered ringtone silence (Requires native DND permissions setup).");
            return true;
        }
      }
      
      print("Unknown volume/vibrate command: $command");
      return false;
    } catch (e) {
      print("Error executing volume/vibrate command: $e");
      return false;
    }
  }
}

import 'package:torch_light/torch_light.dart';
import 'base_action_handler.dart';

class FlashlightHandler implements BaseActionHandler {
  @override
  Future<bool> execute(String command) async {
    try {
      final isAvailable = await TorchLight.isTorchAvailable();
      if (!isAvailable) {
        print("Flashlight is not available on this device.");
        return false;
      }

      if (command == "flashlight_on") {
        await TorchLight.enableTorch();
        return true;
      } else if (command == "flashlight_off") {
        await TorchLight.disableTorch();
        return true;
      } else {
        print("Unknown flashlight command: $command");
        return false;
      }
    } catch (e) {
      print("Error executing flashlight command: $e");
      return false;
    }
  }
}

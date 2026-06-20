import 'package:flutter/services.dart';
import 'base_action_handler.dart';

class MediaHandler implements BaseActionHandler {
  // We use a custom MethodChannel to pass events to native Android logic.
  // The actual Android implementation will map this to the AudioManager.
  static const MethodChannel _channel = MethodChannel('com.example.switch_swap/permissions');

  @override
  Future<bool> execute(String command) async {
    try {
      switch (command) {
        case 'media_play':
          return await _invokeMediaKey(85);
        case 'media_pause':
          // KEYCODE_MEDIA_PLAY_PAUSE = 85
          return await _invokeMediaKey(85);
        case 'media_next':
          // KEYCODE_MEDIA_NEXT = 87
          return await _invokeMediaKey(87);
        case 'media_prev':
          // KEYCODE_MEDIA_PREVIOUS = 88
          return await _invokeMediaKey(88);
        default:
          print("Unknown media command: $command");
          return false;
      }
    } catch (e) {
      print("Error executing media command: $e");
      return false;
    }
  }

  Future<bool> _invokeMediaKey(int keycode) async {
    try {
      await _channel.invokeMethod('dispatchMediaKey', {'keycode': keycode});
      print("Dispatched media keycode: $keycode");
      return true;
    } on MissingPluginException {
      print("Warning: Native MethodChannel 'dispatchMediaKey' not implemented yet. Simulated keycode: $keycode");
      return true; // Simulate success for UI testing
    } catch (e) {
      print("Failed to dispatch media key: $e");
      return false;
    }
  }
}

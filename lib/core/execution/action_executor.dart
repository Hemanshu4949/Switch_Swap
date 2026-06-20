import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/automation_profile.dart';
import 'handlers/base_action_handler.dart';
import 'handlers/flashlight_handler.dart';
import 'handlers/app_launch_handler.dart';
import 'handlers/media_handler.dart';
import 'handlers/volume_handler.dart';

// Temporary Mock Handler for testing routing
class MockHandler extends BaseActionHandler {
  @override
  Future<bool> execute(String command) async {
    print("MockHandler executing command: $command");
    return true;
  }
}

class ActionExecutor {
  // 1. The Registry
  static final Map<String, BaseActionHandler> _handlers = {
    'mock': MockHandler(),
    'flashlight': FlashlightHandler(),
    'launch': AppLaunchHandler(), // Catches 'launch_app'
    'open': AppLaunchHandler(),   // Catches 'open_url'
    'media': MediaHandler(),      // Catches 'media_play', etc.
    'volume': VolumeHandler(),    // Catches 'volume_up', etc.
    'vibrate': VolumeHandler(),   // Catches 'vibrate_short', etc.
  };

  // 2. The Execution Gate
  static Future<void> execute(AutomationProfile profile, WidgetRef? ref) async {
    // 3. Constraint Checking
    if (profile.constraints != null) {
      print("Checking constraints for profile: ${profile.name}...");
      // TODO: Evaluate constraints. If any fail, return early.
      // bool passed = _evaluateConstraints(profile.constraints, ref);
      // if (!passed) return;
    }

    // 4. The Switchboard
    final macro = profile.macro.value;
    if (macro == null || macro.actions.isEmpty) {
      print("Execution failed: no macro or actions found.");
      return;
    }

    // Determine Global Macro Loops
    final macroLoopCount = macro.isLoopActive ? macro.repeatCount : 1;

    for (int m = 0; m < macroLoopCount; m++) {
      if (macroLoopCount > 1) {
        print("Starting Macro execution loop ${m + 1} of $macroLoopCount");
      }

      for (int i = 0; i < macro.actions.length; i++) {
        final action = macro.actions[i];
        final payload = action.payload;
        if (payload == null) continue;

        // Extract the category prefix (e.g., "media_play" -> "media")
        final parts = payload.split('_');
        final category = parts.isNotEmpty ? parts.first : '';
        final handler = _handlers[category];

        // Action-Level Repetition
        final actionRepeatCount = action.repeatCount > 0 ? action.repeatCount : 1;

        for (int a = 0; a < actionRepeatCount; a++) {
          if (handler != null) {
            if (actionRepeatCount > 1) {
              print("Executing '$payload' (Repetition ${a + 1} of $actionRepeatCount)");
            } else {
              print("Executing '$payload'");
            }
            final success = await handler.execute(payload);
            if (!success) {
              print("Execution failed for payload: $payload");
            }
          } else {
            print("No handler found for payload: $payload");
          }

          // Inner repetition delay (if this is not the last repetition of THIS action)
          if (a < actionRepeatCount - 1) {
            await Future.delayed(const Duration(milliseconds: 50));
          }
        }

        // Sequential Action Delay (between unique actions)
        if (i < macro.actions.length - 1) {
          final delayMs = action.delayMs;
          if (delayMs > 0) {
            await Future.delayed(Duration(milliseconds: delayMs));
          } else {
            // Default safety delay to prevent processor load
            await Future.delayed(const Duration(milliseconds: 25));
          }
        }
      }
      
      // Delay before next macro loop (if there is a next loop)
      if (m < macroLoopCount - 1) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
  }
}

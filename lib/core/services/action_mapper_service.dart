import 'package:flutter/material.dart';
import '../model/action_item.dart';
import '../model/action_ui_model.dart';

class ActionMapperService {
  /// Converts a raw database ActionItem into a visually rich ActionItemModel
  static ActionItemModel mapToActionUi(ActionItem item, ColorScheme colorScheme) {
    String title = item.customTitle ?? 'Unknown Action';
    String subtitle = item.customSubtitle ?? 'No description';
    IconData icon = Icons.extension;
    Color iconColor = colorScheme.primary;
    Color iconBg = colorScheme.primaryContainer.withValues(alpha: 0.3);
    String tagLabel = item.customTagLabel ?? 'CMD';
    Color tagColor = colorScheme.secondaryContainer.withValues(alpha: 0.5);

    switch (item.actionType ?? 'system') {
      case 'keyboard':
        title = item.customTitle ?? 'Key Press';
        subtitle = item.customSubtitle ?? 'Simulates a keyboard stroke';
        icon = Icons.keyboard;
        iconColor = Colors.orange;
        iconBg = Colors.orange.withValues(alpha: 0.2);
        tagLabel = item.customTagLabel ?? item.payload ?? '[KEY]';
        tagColor = Colors.orange.withValues(alpha: 0.3);
        break;
      case 'mouse':
        title = item.customTitle ?? 'Mouse Click';
        subtitle = item.customSubtitle ?? 'Simulates a mouse action';
        icon = Icons.mouse;
        iconColor = Colors.deepPurpleAccent;
        iconBg = Colors.deepPurpleAccent.withValues(alpha: 0.2);
        tagLabel = item.customTagLabel ?? item.payload ?? 'CLICK';
        tagColor = Colors.deepPurpleAccent.withValues(alpha: 0.3);
        break;
      case 'shell':
        title = item.customTitle ?? 'Shell Command';
        subtitle = item.customSubtitle ?? 'Executes a bash script';
        icon = Icons.terminal;
        iconColor = colorScheme.onSurfaceVariant;
        iconBg = colorScheme.surfaceContainerHigh;
        tagLabel = item.customTagLabel ?? 'BASH';
        tagColor = colorScheme.surfaceContainerHigh;
        break;
      case 'system':
        title = item.customTitle ?? 'System Action';
        subtitle = item.customSubtitle ?? 'Executes a system command';
        icon = Icons.settings_system_daydream;
        iconColor = Colors.teal;
        iconBg = Colors.teal.withValues(alpha: 0.2);
        tagLabel = item.customTagLabel ?? 'SYS';
        tagColor = Colors.teal.withValues(alpha: 0.3);

        if (item.customTitle == null && item.customSubtitle == null) {
          final payload = item.payload ?? '';
          switch (payload) {
            // Core Utilities
            case 'flashlight_on':
              title = 'Turn Flashlight On';
              subtitle = 'Enables the camera flash';
              icon = Icons.flashlight_on;
              break;
            case 'flashlight_off':
              title = 'Turn Flashlight Off';
              subtitle = 'Disables the camera flash';
              icon = Icons.flashlight_off;
              break;
            case 'media_play':
              title = 'Play Media';
              subtitle = 'Resumes media playback';
              icon = Icons.play_arrow;
              break;
            case 'media_pause':
              title = 'Pause Media';
              subtitle = 'Pauses current media';
              icon = Icons.pause;
              break;
            case 'media_next':
              title = 'Next Track';
              subtitle = 'Skips to the next media track';
              icon = Icons.skip_next;
              break;
            case 'media_prev':
              title = 'Previous Track';
              subtitle = 'Returns to the previous track';
              icon = Icons.skip_previous;
              break;
            case 'volume_up':
              title = 'Increase Volume';
              subtitle = 'Raise the media volume';
              icon = Icons.volume_up;
              break;
            case 'volume_down':
              title = 'Decrease Volume';
              subtitle = 'Lower the media volume';
              icon = Icons.volume_down;
              break;
            case 'volume_mute_media':
              title = 'Mute Media Volume';
              subtitle = 'Mute all media sounds';
              icon = Icons.volume_off;
              break;
            case 'volume_mute_ring':
              title = 'Mute Ringtone';
              subtitle = 'Silence incoming calls';
              icon = Icons.volume_mute;
              break;
            case 'vibrate_short':
              title = 'Short Vibration';
              subtitle = 'Quick haptic feedback';
              icon = Icons.vibration;
              break;
            case 'vibrate_long':
              title = 'Long Vibration';
              subtitle = 'Extended haptic feedback';
              icon = Icons.vibration;
              break;

            // System Modifiers & Toggles
            case 'brightness_up':
              title = 'Increase Brightness';
              subtitle = 'Raise the screen brightness';
              icon = Icons.brightness_6;
              break;
            case 'brightness_down':
              title = 'Decrease Brightness';
              subtitle = 'Lower the screen brightness';
              icon = Icons.brightness_5;
              break;
            case 'brightness_max':
              title = 'Set Maximum Brightness';
              subtitle = 'Set screen brightness to 100%';
              icon = Icons.brightness_high;
              break;
            case 'brightness_min':
              title = 'Set Minimum Brightness';
              subtitle = 'Set screen brightness to 0%';
              icon = Icons.brightness_low;
              break;
            case 'brightness_auto':
              title = 'Toggle Auto-Brightness';
              subtitle = 'Enable or disable adaptive brightness';
              icon = Icons.brightness_auto;
              break;
            case 'screen_keep_awake':
              title = 'Keep Screen Awake';
              subtitle = 'Timeout Override';
              icon = Icons.screen_lock_rotation;
              break;
            case 'bluetooth_on':
              title = 'Turn Bluetooth On';
              subtitle = 'Enable Bluetooth';
              icon = Icons.bluetooth;
              break;
            case 'bluetooth_off':
              title = 'Turn Bluetooth Off';
              subtitle = 'Disable Bluetooth';
              icon = Icons.bluetooth_disabled;
              break;
            case 'dnd_on':
              title = 'Turn Do Not Disturb On';
              subtitle = 'Silence all interruptions';
              icon = Icons.do_not_disturb_on;
              break;
            case 'dnd_off':
              title = 'Turn Do Not Disturb Off';
              subtitle = 'Allow all interruptions';
              icon = Icons.do_not_disturb_off;
              break;
            case 'ring_normal':
              title = 'Set Ring Mode: Normal';
              subtitle = 'Set phone to ring on calls';
              icon = Icons.notifications_active;
              break;
            case 'ring_vibrate':
              title = 'Set Ring Mode: Vibrate';
              subtitle = 'Set phone to vibrate only';
              icon = Icons.volume_down;
              break;
            case 'ring_silent':
              title = 'Set Ring Mode: Silent';
              subtitle = 'Mute all incoming call rings';
              icon = Icons.notifications_off;
              break;

            // System Navigation & UI
            case 'sys_screenshot':
              title = 'Take Screenshot';
              subtitle = 'Capture the current screen content';
              icon = Icons.screenshot;
              break;
            case 'sys_lock_screen':
              title = 'Lock Screen';
              subtitle = 'Turn off the display and lock';
              icon = Icons.screen_lock_portrait;
              break;
            case 'nav_home':
              title = 'Go Home';
              subtitle = 'Navigate to the home screen';
              icon = Icons.home;
              break;
            case 'nav_back':
              title = 'Go Back';
              subtitle = 'Simulate back button press';
              icon = Icons.arrow_back;
              break;
            case 'nav_recents':
              title = 'Recent Apps Menu';
              subtitle = 'Open the app switcher';
              icon = Icons.menu_open;
              break;
            case 'sys_notifications':
              title = 'Expand Notification Shade';
              subtitle = 'Pull down the notification area';
              icon = Icons.swipe_down;
              break;
            case 'sys_quick_settings':
              title = 'Expand Quick Settings Panel';
              subtitle = 'Access quick settings toggles';
              icon = Icons.tune;
              break;
            case 'sys_split_screen':
              title = 'Toggle Split Screen Mode';
              subtitle = 'Enter or exit split screen view';
              icon = Icons.view_agenda;
              break;

            default:
              if (payload.startsWith('launch_app:')) {
                final pkg = payload.split(':').last;
                title = 'Launch App';
                subtitle = 'Opens $pkg';
                icon = Icons.apps;
              } else if (payload.startsWith('open_url:')) {
                final url = payload.substring(9);
                title = 'Open URL';
                subtitle = 'Navigates to $url';
                icon = Icons.link;
              } else {
                title = 'Unknown System Action';
                subtitle = 'Payload: $payload';
                icon = Icons.device_unknown;
              }
          }
        }
        break;
    }

    return ActionItemModel(
      rawItem: item,
      title: title,
      subtitle: subtitle,
      icon: icon,
      iconColor: iconColor,
      iconBackgroundColor: iconBg,
      tagLabel: tagLabel,
      tagColor: tagColor,
      delayAfterMs: item.delayMs,
      repeatCount: item.repeatCount,
      codeSnippet: item.actionType == 'shell' ? item.payload : null,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/model/action_ui_model.dart';
import '../../../core/services/permissions/permission_service.dart';
import '../widgets/category_header.dart';
import '../widgets/list_card.dart';
import '../../constraints/screens/app_picker_sheet.dart';

import '../../../core/model/action_item.dart';
import '../providers/macro_actions_provider.dart';

// Deliverable 1: The Riverpod State
final actionPayloadProvider = StateProvider<String?>((ref) => null);

class ActionSelectionScreen extends ConsumerWidget {
  const ActionSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      // Top Branding AppBar (Matching the Home Screen)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu, color: colorScheme.primary),
        title: Text(
          'KeyMapper Pro',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.bolt, color: colorScheme.primary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Back Button and Screen Title
            Row(
              children: [
                InkWell(
                  onTap: () => context.pop(), // Basic pop navigation
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHigh,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.arrow_back, color: colorScheme.onSurface),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Select Action',
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 2. Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search over 100+ commands...',
                prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
              ),
            ),
            const SizedBox(height: 8),

            // 3. Category: Core Utilities & Media
            ActionCategoryHeader(
              title: 'Core Utilities & Media',
              indicatorColor: colorScheme.primary,
            ),
            _buildCoreUtilitiesAndMedia(colorScheme, context, ref),

            // 4. Category: System Modifiers & Toggles
            ActionCategoryHeader(
              title: 'System Modifiers & Toggles',
              indicatorColor: colorScheme.secondary,
            ),
            _buildSystemModifiers(colorScheme, context, ref),

            // 5. Category: System Navigation & UI
            ActionCategoryHeader(
              title: 'System Navigation & UI (Requires Accessibility)',
              indicatorColor: colorScheme.tertiary,
            ),
            _buildSystemNavigation(colorScheme, context, ref),

            const SizedBox(height: 40), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildCoreUtilitiesAndMedia(ColorScheme colorScheme, BuildContext context, WidgetRef ref) {
    final actions = [
      _buildCard('Launch Application', 'launch_app_picker', Icons.apps, colorScheme.primary, colorScheme.primaryContainer, 'Choose an installed app to open', context, ref),
      _buildCard('Open URL / Website', 'open_url', Icons.link, colorScheme.primary, colorScheme.primaryContainer, 'Launch a webpage in your default browser', context, ref),
      _buildCard('Turn Flashlight On', 'flashlight_on', Icons.flashlight_on, colorScheme.primary, colorScheme.primaryContainer, 'Instantly activate device flashlight', context, ref),
      _buildCard('Turn Flashlight Off', 'flashlight_off', Icons.flashlight_off, colorScheme.primary, colorScheme.primaryContainer, 'Deactivate device flashlight', context, ref),
      _buildCard('Play Media', 'media_play', Icons.play_arrow, colorScheme.onSurfaceVariant, colorScheme.surfaceContainerHigh, 'Resume active media playback', context, ref),
      _buildCard('Pause Media', 'media_pause', Icons.pause, colorScheme.onSurfaceVariant, colorScheme.surfaceContainerHigh, 'Pause active media playback', context, ref),
      _buildCard('Next Track', 'media_next', Icons.skip_next, colorScheme.onSurfaceVariant, colorScheme.surfaceContainerHigh, 'Skip to the next media item', context, ref),
      _buildCard('Previous Track', 'media_prev', Icons.skip_previous, colorScheme.onSurfaceVariant, colorScheme.surfaceContainerHigh, 'Go back to the previous media item', context, ref),
      _buildCard('Increase Volume', 'volume_up', Icons.volume_up, colorScheme.onSurfaceVariant, colorScheme.surfaceContainerHigh, 'Raise the media volume', context, ref),
      _buildCard('Decrease Volume', 'volume_down', Icons.volume_down, colorScheme.onSurfaceVariant, colorScheme.surfaceContainerHigh, 'Lower the media volume', context, ref),
      _buildCard('Mute Media Volume', 'volume_mute_media', Icons.volume_off, colorScheme.onSurfaceVariant, colorScheme.surfaceContainerHigh, 'Mute all media sounds', context, ref),
      _buildCard('Mute Ringtone', 'volume_mute_ring', Icons.volume_mute, colorScheme.onSurfaceVariant, colorScheme.surfaceContainerHigh, 'Silence incoming calls', context, ref),
      _buildCard('Vibrate Device (Short)', 'vibrate_short', Icons.vibration, colorScheme.onSurfaceVariant, colorScheme.surfaceContainerHigh, 'Trigger a short haptic feedback', context, ref),
      _buildCard('Vibrate Device (Long)', 'vibrate_long', Icons.vibration, colorScheme.onSurfaceVariant, colorScheme.surfaceContainerHigh, 'Trigger a long haptic feedback', context, ref),
    ];
    return Column(children: actions);
  }

  Widget _buildSystemModifiers(ColorScheme colorScheme, BuildContext context, WidgetRef ref) {
    final actions = [
      _buildCard('Increase Brightness', 'brightness_up', Icons.brightness_6, colorScheme.secondary, colorScheme.secondaryContainer, 'Raise the screen brightness', context, ref),
      _buildCard('Decrease Brightness', 'brightness_down', Icons.brightness_5, colorScheme.secondary, colorScheme.secondaryContainer, 'Lower the screen brightness', context, ref),
      _buildCard('Set Maximum Brightness', 'brightness_max', Icons.brightness_high, colorScheme.secondary, colorScheme.secondaryContainer, 'Set screen brightness to 100%', context, ref),
      _buildCard('Set Minimum Brightness', 'brightness_min', Icons.brightness_low, colorScheme.secondary, colorScheme.secondaryContainer, 'Set screen brightness to 0%', context, ref),
      _buildCard('Toggle Auto-Brightness', 'brightness_auto', Icons.brightness_auto, colorScheme.secondary, colorScheme.secondaryContainer, 'Enable or disable adaptive brightness', context, ref),
      _buildCard('Keep Screen Awake', 'screen_keep_awake', Icons.screen_lock_rotation, colorScheme.secondary, colorScheme.secondaryContainer, 'Timeout Override', context, ref),
      _buildCard('Turn Bluetooth On', 'bluetooth_on', Icons.bluetooth, colorScheme.secondary, colorScheme.secondaryContainer, 'Enable Bluetooth', context, ref),
      _buildCard('Turn Bluetooth Off', 'bluetooth_off', Icons.bluetooth_disabled, colorScheme.secondary, colorScheme.secondaryContainer, 'Disable Bluetooth', context, ref),
      _buildCard('Turn Do Not Disturb On', 'dnd_on', Icons.do_not_disturb_on, colorScheme.secondary, colorScheme.secondaryContainer, 'Silence all interruptions', context, ref),
      _buildCard('Turn Do Not Disturb Off', 'dnd_off', Icons.do_not_disturb_off, colorScheme.secondary, colorScheme.secondaryContainer, 'Allow all interruptions', context, ref),
      _buildCard('Set Ring Mode: Normal', 'ring_normal', Icons.notifications_active, colorScheme.secondary, colorScheme.secondaryContainer, 'Set phone to ring on calls', context, ref),
      _buildCard('Set Ring Mode: Vibrate', 'ring_vibrate', Icons.volume_down, colorScheme.secondary, colorScheme.secondaryContainer, 'Set phone to vibrate only', context, ref),
      _buildCard('Set Ring Mode: Silent', 'ring_silent', Icons.notifications_off, colorScheme.secondary, colorScheme.secondaryContainer, 'Mute all incoming call rings', context, ref),
    ];
    return Column(children: actions);
  }

  Widget _buildSystemNavigation(ColorScheme colorScheme, BuildContext context, WidgetRef ref) {
    final actions = [
      _buildCard('Take Screenshot', 'sys_screenshot', Icons.screenshot, colorScheme.tertiary, colorScheme.tertiaryContainer, 'Capture the current screen content', context, ref),
      _buildCard('Lock Screen / Turn Screen Off', 'sys_lock_screen', Icons.screen_lock_portrait, colorScheme.tertiary, colorScheme.tertiaryContainer, 'Turn off the display and lock', context, ref),
      _buildCard('Go Home', 'nav_home', Icons.home, colorScheme.tertiary, colorScheme.tertiaryContainer, 'Navigate to the home screen', context, ref),
      _buildCard('Go Back', 'nav_back', Icons.arrow_back, colorScheme.tertiary, colorScheme.tertiaryContainer, 'Simulate back button press', context, ref),
      _buildCard('Recent Apps Menu', 'nav_recents', Icons.menu_open, colorScheme.tertiary, colorScheme.tertiaryContainer, 'Open the app switcher', context, ref),
      _buildCard('Expand Notification Shade', 'sys_notifications', Icons.swipe_down, colorScheme.tertiary, colorScheme.tertiaryContainer, 'Pull down the notification area', context, ref),
      _buildCard('Expand Quick Settings Panel', 'sys_quick_settings', Icons.tune, colorScheme.tertiary, colorScheme.tertiaryContainer, 'Access quick settings toggles', context, ref),
      _buildCard('Toggle Split Screen Mode', 'sys_split_screen', Icons.view_agenda, colorScheme.tertiary, colorScheme.tertiaryContainer, 'Enter or exit split screen view', context, ref),
    ];
    return Column(children: actions);
  }

  Widget _buildCard(String title, String payload, IconData icon, Color iconColor, Color iconBgColor, String subtitle, BuildContext context, WidgetRef ref) {
    final model = ActionItemModel(
      title: title,
      subtitle: subtitle,
      icon: icon,
      iconColor: iconColor,
      iconBackgroundColor: iconBgColor.withValues(alpha: 0.3),
    );
    return ActionListCard(
      action: model,
      onTap: () => _handleActionSelection(payload, context, ref),
    );
  }

  Future<void> _handleActionSelection(String payload, BuildContext context, WidgetRef ref) async {
    // 1. Categorize the Payload
    final accessibilityRequiredPayloads = [
      'sys_screenshot', 'sys_lock_screen', 'nav_home', 'nav_back',
      'nav_recents', 'sys_notifications', 'sys_quick_settings', 'sys_split_screen'
    ];

    // 2. The Check
    if (accessibilityRequiredPayloads.contains(payload)) {
      final permissionService = ref.read(permissionServiceProvider);
      final hasPermission = await permissionService.hasAutomationPermissions();

      // 3. The Block
      if (!hasPermission) {
        if (!context.mounted) return;
        
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Permission Required"),
            content: const Text(
                "This action requires the KeyMapper Accessibility Service to interact with the Android system on your behalf. Please enable it in Settings."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  permissionService.triggerAccessibilityPrompt();
                },
                child: const Text("Open Settings"),
              ),
            ],
          ),
        );
        return; // Halt execution and don't pop
      }
    }

    // 4. The Pass
    if (payload == 'launch_app_picker') {
      final selectedAppPackage = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (context) => const AppPickerSheet(),
      );

      if (selectedAppPackage != null && selectedAppPackage.isNotEmpty) {
        final payloadVal = 'launch_app:$selectedAppPackage';
        final item = ActionItem()
          ..payload = payloadVal
          ..repeatCount = 1
          ..delayMs = 0;
        ref.read(macroActionsProvider.notifier).addAction(item);
        if (context.mounted) {
          context.pop(payloadVal);
        }
      }
    } else if (payload == 'open_url') {
      final urlController = TextEditingController();
      final url = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Enter URL'),
          content: TextField(
            controller: urlController,
            decoration: const InputDecoration(
              hintText: 'https://example.com',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.url,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(urlController.text),
              child: const Text('Save'),
            ),
          ],
        ),
      );

      if (url != null && url.isNotEmpty) {
        final payloadVal = 'open_url:$url';
        final item = ActionItem()
          ..payload = payloadVal
          ..repeatCount = 1
          ..delayMs = 0;
        ref.read(macroActionsProvider.notifier).addAction(item);
        if (context.mounted) {
          context.pop(payloadVal);
        }
      }
    } else {
      final item = ActionItem()
        ..payload = payload
        ..repeatCount = 1
        ..delayMs = 0;
      ref.read(macroActionsProvider.notifier).addAction(item);
      context.pop(payload);
    }
  }
}

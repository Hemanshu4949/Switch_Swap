import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/model/automation_profile.dart';
import '../../../core/model/macro.dart';
import '../../../core/providers/database_provider.dart';
import '../../../core/model/action_item.dart';
import 'package:isar/isar.dart';
import '../../triggers/screen/trigger_screen.dart';
import '../../actions/screens/macro_selection_screen.dart';
import '../../../core/providers/automation_profiles_provider.dart';
import 'package:go_router/go_router.dart';
import 'app_picker_sheet.dart';

import '../../../core/state/draft_profile_provider.dart';
import '../../actions/providers/macro_actions_provider.dart';

class ConstraintsScreen extends ConsumerStatefulWidget {
  const ConstraintsScreen({super.key});

  @override
  ConsumerState<ConstraintsScreen> createState() => _ConstraintsScreenState();
}

class _ConstraintsScreenState extends ConsumerState<ConstraintsScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final draft = ref.watch(draftProfileProvider);
    final requireScreenOn = draft?.constraints?.requireScreenOn ?? false;
    final requireDeviceUnlocked = draft?.constraints?.requireDeviceUnlocked ?? false;
    final requireWiFi = draft?.constraints?.requireWiFi ?? false;
    final requireCharging = draft?.constraints?.requireCharging ?? false;
    final requireLandscape = draft?.constraints?.requireLandscape ?? false;
    final requireHeadset = draft?.constraints?.requireHeadset ?? false;
    final requireSpecificApp = draft?.constraints?.requireSpecificApp;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Execution Constraints',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // 1. Screen State
          SwitchListTile(
            title: const Text(
              'Require Screen On',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Macro will only run if the device display is awake.',
            ),
            value: requireScreenOn,
            onChanged: (val) {
              final draft = ref.read(draftProfileProvider);
              if (draft != null) {
                final currentConstraints = draft.constraints ?? ExecutionConstraints();
                currentConstraints.requireScreenOn = val;
                ref.read(draftProfileProvider.notifier).state = draft.copyWith(constraints: currentConstraints);
              }
            },
            secondary: Icon(Icons.screen_lock_portrait, color: colorScheme.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            tileColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          const SizedBox(height: 16),

          // 2. Device State
          SwitchListTile(
            title: const Text(
              'Require Device Unlocked',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Macro will only run if the phone is unlocked.',
            ),
            value: requireDeviceUnlocked,
            onChanged: (val) {
              final draft = ref.read(draftProfileProvider);
              if (draft != null) {
                final currentConstraints = draft.constraints ?? ExecutionConstraints();
                currentConstraints.requireDeviceUnlocked = val;
                ref.read(draftProfileProvider.notifier).state = draft.copyWith(constraints: currentConstraints);
              }
            },
            secondary: Icon(Icons.lock_open, color: colorScheme.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            tileColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          const SizedBox(height: 16),

          // 3. Wi-Fi State
          SwitchListTile(
            title: const Text(
              'Require Wi-Fi Connection',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Macro will only run if connected to Wi-Fi.',
            ),
            value: requireWiFi,
            onChanged: (val) {
              final draft = ref.read(draftProfileProvider);
              if (draft != null) {
                final currentConstraints = draft.constraints ?? ExecutionConstraints();
                currentConstraints.requireWiFi = val;
                ref.read(draftProfileProvider.notifier).state = draft.copyWith(constraints: currentConstraints);
              }
            },
            secondary: Icon(Icons.wifi, color: colorScheme.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            tileColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          const SizedBox(height: 16),

          // 4. Charging State
          SwitchListTile(
            title: const Text(
              'Require Charging',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Macro will only run if the device is plugged in.',
            ),
            value: requireCharging,
            onChanged: (val) {
              final draft = ref.read(draftProfileProvider);
              if (draft != null) {
                final currentConstraints = draft.constraints ?? ExecutionConstraints();
                currentConstraints.requireCharging = val;
                ref.read(draftProfileProvider.notifier).state = draft.copyWith(constraints: currentConstraints);
              }
            },
            secondary: Icon(Icons.battery_charging_full, color: colorScheme.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            tileColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          const SizedBox(height: 16),

          // 5. Orientation State
          SwitchListTile(
            title: const Text(
              'Require Landscape Mode',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Macro will only run if device is sideways.',
            ),
            value: requireLandscape,
            onChanged: (val) {
              final draft = ref.read(draftProfileProvider);
              if (draft != null) {
                final currentConstraints = draft.constraints ?? ExecutionConstraints();
                currentConstraints.requireLandscape = val;
                ref.read(draftProfileProvider.notifier).state = draft.copyWith(constraints: currentConstraints);
              }
            },
            secondary: Icon(Icons.screen_rotation, color: colorScheme.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            tileColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          const SizedBox(height: 16),

          // 6. Headset State
          SwitchListTile(
            title: const Text(
              'Require Headset Connected',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Macro will only run if headphones are plugged in or paired.',
            ),
            value: requireHeadset,
            onChanged: (val) {
              final draft = ref.read(draftProfileProvider);
              if (draft != null) {
                final currentConstraints = draft.constraints ?? ExecutionConstraints();
                currentConstraints.requireHeadset = val;
                ref.read(draftProfileProvider.notifier).state = draft.copyWith(constraints: currentConstraints);
              }
            },
            secondary: Icon(Icons.headphones, color: colorScheme.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            tileColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          const SizedBox(height: 16),

          // 3. App State
          ListTile(
            title: const Text(
              'Require Specific App',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              requireSpecificApp ?? 'Any App',
              style: TextStyle(
                color: requireSpecificApp != null
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
            onTap: () async {
              final result = await showModalBottomSheet<String>(
                context: context,
                isScrollControlled: true, // Make it tall!
                useSafeArea: true,
                builder: (context) => const AppPickerSheet(),
              );
              if (result != null) {
                final draft = ref.read(draftProfileProvider);
                if (draft != null) {
                  final currentConstraints = draft.constraints ?? ExecutionConstraints();
                  currentConstraints.requireSpecificApp = result;
                  ref.read(draftProfileProvider.notifier).state = draft.copyWith(constraints: currentConstraints);
                }
              }
            },
            leading: Icon(Icons.apps, color: colorScheme.primary),
            trailing: const Icon(Icons.chevron_right),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            tileColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: () {
                final draft = ref.read(draftProfileProvider);
                if (draft == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error: No draft profile found.')),
                  );
                  return;
                }

                final actions = ref.read(macroActionsProvider);
                final selectedMacroIdStr = ref.read(selectedMacroIdProvider);

                Macro? linkedMacro;

                if (selectedMacroIdStr != null) {
                  // User chose an existing pre-made macro. Fetch it!
                  final isar = Isar.getInstance()!;
                  final int id = int.parse(selectedMacroIdStr);
                  linkedMacro = isar.macros.getSync(id);
                  
                  if (linkedMacro == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Error: Selected macro no longer exists.')),
                    );
                    return;
                  }
                } else if (actions.isNotEmpty) {
                  // User selected a single action. Create a new on-the-fly Macro
                  linkedMacro = Macro(
                    name: 'Macro for ${draft.name}',
                    actions: actions,
                  );
                } else {
                  linkedMacro = Macro(
                    name: 'Empty Macro',
                    actions: [ActionItem()..payload = 'No Action'],
                  );
                }

                // 2. Draft is already constructed. We just make sure it's valid.
                final newProfile = draft;

                // 3. Save to Isar and update Riverpod state synchronously
                ref.read(automationProfilesProvider.notifier).addProfile(newProfile, linkedMacro);

                // 4. Print a beautifully formatted multi-line debugPrint
                debugPrint('''
==================================================
              NEW AUTOMATION PROFILE SAVED
==================================================
Profile Name       : ${newProfile.name}
Trigger Sequence   : ${newProfile.triggerSequence.join(', ')}
Action             : ${linkedMacro.actions.map((a) => a.payload).join(', ')}
Require Screen On  : ${newProfile.constraints?.requireScreenOn}
Device Unlocked    : ${newProfile.constraints?.requireDeviceUnlocked}
Specific App       : ${newProfile.constraints?.requireSpecificApp ?? "Any App"}
IsEnabled          : ${newProfile.isEnabled}
==================================================
''');

                // Capture navigator to reset the branch's stack
                final nav = Navigator.of(context);

                // 5. Execute go to dashboard
                context.go('/dashboard');

                // Reset internal navigation to trigger screen for this branch
                nav.popUntil((route) => route.isFirst);

                // 4. Invalidate/reset all those providers
                ref.invalidate(draftProfileProvider);
                ref.invalidate(macroActionsProvider);
                ref.invalidate(selectedMacroIdProvider);
                ref.invalidate(selectedActionProvider);
                ref.invalidate(isSingleActionSelectedProvider);
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Automation Saved & State Cleared!')),
                );
              },
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                "Finish & Save Automation",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

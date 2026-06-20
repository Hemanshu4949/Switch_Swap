import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:isar/isar.dart';
import '../../../core/model/macro.dart';
import '../../../core/model/automation_profile.dart';
import '../../../core/providers/home_provider.dart';
import '../../../core/providers/automation_profiles_provider.dart';
import '../../../core/execution/action_executor.dart';
import '../widgets/mapping_card.dart';
import '../../../core/services/action_mapper_service.dart';
import '../providers/permission_provider.dart';
import '../../../core/engine/permission_service.dart';
import '../../../core/providers/hardware_status_provider.dart';
import '../../../core/engine/hardware_listener.dart';

final macrosStreamProvider = StreamProvider<List<Macro>>((ref) {
  final isar = Isar.getInstance()!;
  return isar.macros.filter().isStandaloneEqualTo(true).watch(fireImmediately: true);
});

class KeyMapperHomeScreen extends ConsumerWidget {
  const KeyMapperHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Grab the theme and color scheme ONCE at the top of the build method.
    // This hooks the UI into Flutter's reactive theme engine.
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final homeState = ref.watch(homeProvider);
    final profiles = ref.watch(automationProfilesProvider);
    final isAccessibilityEnabled = ref.watch(accessibilityPermissionProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: TabBar(
            indicatorColor: colorScheme.primary,
            labelColor: colorScheme.primary,
            unselectedLabelColor: colorScheme.onSurfaceVariant,
            tabs: const [
              Tab(icon: Icon(Icons.alt_route), text: 'Mappers'),
              Tab(icon: Icon(Icons.terminal), text: 'Macros'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Mappers
            SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Pass the extracted theme variables down to your helper methods
            // to avoid multiple costly Theme.of(context) lookups.
            
            if (!isAccessibilityEnabled) ...[
              _buildWarningCard(colorScheme, textTheme),
              const SizedBox(height: 32),
            ],

            // BUG FIX: You forgot to include the header section! Re-added here.
            _buildHeaderSection(ref, homeState.isMasterActive, colorScheme, textTheme),

            const SizedBox(height: 24),

            Builder(
              builder: (context) {
                // Filter out 'manual' trigger sources so Macros don't show on the Home Screen
                final displayProfiles = profiles.where((p) => p.triggerType != 'manual').toList();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayProfiles.length,
                  itemBuilder: (context, index) {
                    final profile = displayProfiles[index];
                    
                    final keysList = profile.triggerSequence;
                    final subtitleText = profile.macro.value?.actions.map((a) {
                      return ActionMapperService.mapToActionUi(a, colorScheme).title;
                    }).join(', ') ?? '';

                    final isSingleAction = profile.macro.value?.isStandalone == false;
                    final macroName = isSingleAction ? null : profile.macro.value?.name;
                    final actionName = isSingleAction ? subtitleText : null;

                    return Dismissible(
                      key: ValueKey(profile.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 24),
                        decoration: BoxDecoration(
                          color: colorScheme.error,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Icon(Icons.delete, color: colorScheme.onError, size: 32),
                      ),
                      onDismissed: (direction) {
                        ref.read(automationProfilesProvider.notifier).deleteProfile(profile.id);
                      },
                      child: MappingCard(
                        keys: keysList.isNotEmpty ? keysList : ['Unmapped'],
                        iconLeft: Icons.bolt, 
                        iconRight: Icons.flash_on, 
                        title: profile.name.isNotEmpty 
                            ? profile.name 
                            : (macroName ?? actionName ?? 'Unnamed Profile'),
                        subtitle: profile.triggerType,
                        macroName: macroName,
                        actionName: actionName,
                        isActive: profile.isEnabled,
                        isError: false, 
                        onToggle: (val) => ref.read(automationProfilesProvider.notifier).toggleProfileState(profile.id, val),
                      ),
                    );
                  },
                );
              }
            ),

                  const SizedBox(height: 16),
                  _buildCreateNewCard(colorScheme, textTheme),
                  const SizedBox(height: 80),
                ],
              ),
            ),
            
            // Tab 2: Macros
            _buildMacrosTab(ref, colorScheme, textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildMacrosTab(WidgetRef ref, ColorScheme colorScheme, TextTheme textTheme) {
    final macrosAsync = ref.watch(macrosStreamProvider);

    return macrosAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
      data: (macros) {
        if (macros.isEmpty) {
          return const Center(child: Text('No macros found.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: macros.length,
          itemBuilder: (context, index) {
            final macro = macros[index];

            return Card(
              color: colorScheme.surfaceContainerLow,
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                macro.name,
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              if (macro.isLoopActive)
                                Text(
                                  'Loops: ${macro.repeatCount}x',
                                  style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary),
                                ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.play_circle_fill, color: colorScheme.primary, size: 32),
                          onPressed: () {
                            // Run the macro directly!
                            final dummyProfile = AutomationProfile(
                              name: 'Manual Execution',
                              triggerType: 'Manual',
                            )..macro.value = macro;
                            ActionExecutor.execute(dummyProfile, ref);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Playing ${macro.name}...')),
                            );
                          },
                        )
                      ],
                    ),
                    const Divider(),
                    if (macro.actions.isEmpty)
                      Text('Empty Macro', style: textTheme.bodySmall)
                    else
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: macro.actions.map((action) {
                          return Chip(
                            avatar: Icon(Icons.bolt, size: 16, color: colorScheme.primary),
                            label: Text(
                              '${action.payload} (x${action.repeatCount})',
                              style: TextStyle(color: colorScheme.onSurfaceVariant),
                            ),
                            backgroundColor: colorScheme.surfaceContainerHighest,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // --- Helper Methods ---
  // Notice we inject ColorScheme and TextTheme as parameters.

  Widget _buildHeaderSection(
      WidgetRef ref,
      bool isMasterActive,
      ColorScheme colorScheme,
      TextTheme textTheme,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Active\nMappings',
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 8),
            _buildHardwareStatusBadge(ref, colorScheme, textTheme),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Text(
                'Mapper is\nActive',
                style: textTheme.labelSmall?.copyWith(
                  height: 1.2,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 8),
              Switch(
                value: isMasterActive,
                onChanged: (val) => ref.read(homeProvider.notifier).toggleMaster(val),
                // Replaced the hardcoded green. We now use the theme's tertiary color
                // (or primary depending on how you configured app_theme.dart)
                activeThumbColor: colorScheme.tertiary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHardwareStatusBadge(WidgetRef ref, ColorScheme colorScheme, TextTheme textTheme) {
    // In the Headless Engine architecture, if the Accessibility Service is enabled, the engine is running natively.
    final isListening = ref.watch(accessibilityPermissionProvider);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isListening 
          ? Colors.green.withValues(alpha: 0.1) 
          : Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isListening ? Colors.green : Colors.red,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isListening ? Icons.check_circle : Icons.error,
            size: 14,
            color: isListening ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 4),
          Text(
            isListening ? 'Hardware Engine Active' : 'Engine Stopped',
            style: textTheme.labelSmall?.copyWith(
              color: isListening ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningCard(ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: colorScheme.error),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Permissions\nMissing',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.error,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'KeyMapper needs\naccessibility access to\nintercept keys.',
                  style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              PermissionService.openAccessibilitySettings();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('FIX', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateNewCard(ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          Text(
            'Create New Trigger',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Map a new sequence',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
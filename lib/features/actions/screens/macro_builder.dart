import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/model/macro.dart';
import '../../../core/model/action_item.dart';
import '../../../core/model/automation_profile.dart';
import '../../../core/providers/automation_profiles_provider.dart';
import '../../../core/services/action_mapper_service.dart';
import '../providers/macro_builder_controller.dart';
import '../widgets/execution_loop_card.dart';
import '../widgets/macro_step_card.dart';

class MacroBuilderScreen extends ConsumerWidget {
  const MacroBuilderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Watch the state and the controller from Riverpod
    final macroState = ref.watch(macroBuilderControllerProvider);
    final controller = ref.read(macroBuilderControllerProvider.notifier);

    return Scaffold(
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
            Text(
              'Rapid Fire Sequence',
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Design your macro execution chain. Drag to reorder.',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),

            // Macro Name Field
            TextFormField(
              initialValue: macroState.name,
              onChanged: controller.updateName,
              decoration: InputDecoration(
                labelText: 'Macro Name',
                hintText: 'e.g., Photoshop Shortcut',
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 24),

            // The Timeline Builder
            _buildTimeline(context, macroState, controller, colorScheme, textTheme),

            const SizedBox(height: 24),

            // Add Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final result = await context.push<String>('macros/actions');
                  if (result != null && result.isNotEmpty) {
                    final newAction = ActionItem()
                      ..actionType = 'system'
                      ..payload = result;
                    controller.addAction(newAction);
                  }
                },
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Add Action'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Loop Configuration
            ExecutionLoopCard(
              isLoopActive: macroState.isLoopActive,
              repeatCount: macroState.repeatCount,
              onToggle: controller.toggleLoop,
              onIncrement: controller.incrementGlobalRepeat,
              onDecrement: controller.decrementGlobalRepeat,
            ),

            const SizedBox(height: 24),

            // Save Macro Button
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () async {
                  if (macroState.name.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Please enter a Macro name before saving.'),
                        backgroundColor: colorScheme.error,
                      ),
                    );
                    return;
                  }

                  if (macroState.actions.length < 2) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('A macro must contain at least 2 actions. Please add more.'),
                        backgroundColor: colorScheme.error,
                      ),
                    );
                    return;
                  }

                  // Save the Macro to the DB
                  await controller.saveMacro();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Macro "${macroState.name.trim()}" saved to library!')),
                    );
                    context.pop();
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Macro'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline(
      BuildContext context,
      Macro macroState,
      MacroBuilderController controller,
      ColorScheme colorScheme,
      TextTheme textTheme
      ) {
    if (macroState.actions.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.auto_awesome, size: 48, color: colorScheme.primary.withValues(alpha: 0.5)),
              const SizedBox(height: 16),
              Text(
                'Add your first action to start building this macro',
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        _buildVerticalLine(colorScheme),
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          onReorder: controller.reorderActions,
          children: [
            for (int i = 0; i < macroState.actions.length; i++)
              Container(
                key: ValueKey('step_$i'),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MacroStepCard(
                      step: ActionMapperService.mapToActionUi(macroState.actions[i], colorScheme),
                      onDragHandleTap: () {},
                      onIncrement: () => controller.incrementActionRepeat(i),
                      onDecrement: () => controller.decrementActionRepeat(i),
                      onRemove: () => controller.removeAction(i),
                    ),
                    if (i < macroState.actions.length - 1) ...[
                      _buildVerticalLine(colorScheme),
                      _buildDelayBadge(
                          context,
                          macroState.actions[i].delayMs,
                              (newDelay) => controller.updateActionDelay(i, newDelay),
                          colorScheme,
                          textTheme
                      ),
                    ],
                    _buildVerticalLine(colorScheme),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildVerticalLine(ColorScheme colorScheme) {
    return Container(
      height: 16,
      width: 3,
      color: colorScheme.surfaceContainerHighest,
    );
  }

  Widget _buildDelayBadge(
      BuildContext context,
      int ms,
      Function(int) onUpdate,
      ColorScheme colorScheme,
      TextTheme textTheme
      ) {
    return GestureDetector(
      onTap: () async {
        final textController = TextEditingController(text: ms.toString());
        final result = await showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Set Delay (ms)'),
            content: TextField(
              controller: textController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(suffixText: 'ms'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, textController.text),
                child: const Text('Save'),
              ),
            ],
          ),
        );
        if (result != null && int.tryParse(result) != null) {
          onUpdate(int.parse(result));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colorScheme.outlineVariant, width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.schedule, size: 14, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: 6),
            Text(
              '${ms}ms',
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
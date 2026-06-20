import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';

import '../../../core/model/action_item.dart';
import '../../../core/providers/database_provider.dart';
import '../../../core/model/macro.dart';
import '../providers/macro_actions_provider.dart';

final savedMacrosProvider = StreamProvider<List<Macro>>((ref) async* {
  final isar = Isar.getInstance()!;
  yield* isar.macros.where().watch(fireImmediately: true);
});

final selectedMacroIdProvider = StateProvider<String?>((ref) => null);
final isSingleActionSelectedProvider = StateProvider<bool>((ref) => false);
final macroSearchQueryProvider = StateProvider<String>((ref) => "");
final selectedActionProvider = StateProvider<String?>((ref) => null);

class MacroSelectionScreen extends ConsumerStatefulWidget {
  const MacroSelectionScreen({super.key});

  @override
  ConsumerState<MacroSelectionScreen> createState() => _MacroSelectionScreenState();
}

class _MacroSelectionScreenState extends ConsumerState<MacroSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(macroSearchQueryProvider.notifier).state = "";
    });
  }



  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _selectMacro(String id, String name) {
    ref.read(selectedMacroIdProvider.notifier).state = id;
    ref.read(isSingleActionSelectedProvider.notifier).state = false;
    ref.read(selectedActionProvider.notifier).state = null;
  }

  void _selectSingleAction() async {
    ref.read(isSingleActionSelectedProvider.notifier).state = true;
    ref.read(selectedMacroIdProvider.notifier).state = null;
    final result = await context.push<String>('/trigger/action/select');
    if (result != null) {
      ref.read(selectedActionProvider.notifier).state = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final searchQuery = ref.watch(macroSearchQueryProvider);
    final selectedMacroId = ref.watch(selectedMacroIdProvider);
    final isSingleActionSelected = ref.watch(isSingleActionSelectedProvider);
    final selectedAction = ref.watch(selectedActionProvider);

    final macrosAsyncValue = ref.watch(savedMacrosProvider);

    final bool canProceed = selectedMacroId != null || selectedAction != null;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text("Select Payload"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              "Choose what happens when this trigger fires",
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              children: [
                // 1. Search Bar
                SearchBar(
                  controller: _searchController,
                  hintText: "Search macros...",
                  leading: const Icon(Icons.search),
                  padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  onChanged: (value) => ref.read(macroSearchQueryProvider.notifier).state = value,
                  elevation: const WidgetStatePropertyAll<double>(1.0),
                ),
                const SizedBox(height: 24),

                // 2. The "Single Action" Entry Point (Prominent)
                if (selectedAction == null)
                  Card(
                    elevation: isSingleActionSelected ? 4.0 : 1.0,
                    color: isSingleActionSelected 
                        ? colorScheme.primaryContainer 
                        : colorScheme.surfaceContainerHighest,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(
                        color: isSingleActionSelected ? colorScheme.primary : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: InkWell(
                      onTap: _selectSingleAction,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.bolt_outlined, color: colorScheme.onPrimary, size: 28),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Assign Single Action",
                                    style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Launch an app, toggle a setting, etc.",
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: colorScheme.primary, size: 18),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  Card(
                    color: colorScheme.primaryContainer,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    clipBehavior: Clip.antiAlias, // Ensure InkWell ripple effect respects rounded corners
                    child: InkWell(
                      onTap: _selectSingleAction,
                      child: ListTile(
                        leading: Icon(Icons.flash_on, color: colorScheme.onPrimaryContainer),
                        title: Text(selectedAction, style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onPrimaryContainer)),
                        subtitle: const Text('Action to perform (Tap to change)'),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle_outline, color: colorScheme.error),
                          onPressed: () {
                            ref.read(selectedActionProvider.notifier).state = null;
                            ref.read(isSingleActionSelectedProvider.notifier).state = false;
                          },
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 36),

                // 3. Pre-Defined Macros Header
                        Text(
                  "YOUR PRE-MADE MACROS",
                  style: textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 16),

                // 4. Pre-Defined Macros List
                macrosAsyncValue.when(
                  data: (macros) {
                    final filteredMacros = macros.where((m) {
                      return m.name.toLowerCase().contains(searchQuery.toLowerCase());
                    }).toList();

                    if (filteredMacros.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: Center(
                          child: Text(
                            "No macros found",
                            style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), // Scroll managed by parent ListView
                      itemCount: filteredMacros.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final macro = filteredMacros[index];
                        final String macroIdStr = macro.id.toString();
                        final isSelected = selectedMacroId == macroIdStr;
                        
                        final int actionsCount = macro.actions.length;
                        int totalDelay = 0;
                        for (var action in macro.actions) {
                          totalDelay += action.delayMs;
                        }

                        return Card(
                          elevation: isSelected ? 2.0 : 0.0,
                          color: isSelected 
                              ? colorScheme.secondaryContainer 
                              : colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: BorderSide(
                              color: isSelected ? colorScheme.secondary : colorScheme.outlineVariant,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: InkWell(
                            onTap: () => _selectMacro(macroIdStr, macro.name),
                            borderRadius: BorderRadius.circular(16.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                              child: Row(
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
                                        const SizedBox(height: 4),
                                        Text(
                                          "$actionsCount actions • ${totalDelay > 0 ? '${totalDelay}ms' : 'No'} delay",
                                          style: textTheme.bodySmall?.copyWith(
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Radio<String>(
                                    value: macroIdStr,
                                    groupValue: selectedMacroId,
                                    onChanged: (value) {
                                      if (value != null) _selectMacro(value, macro.name);
                                    },
                                    activeColor: colorScheme.secondary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: Padding(padding: EdgeInsets.all(32.0), child: CircularProgressIndicator())),
                  error: (err, stack) => Center(child: Text("Error loading macros: $err")),
                ),
              ],
            ),
          ),

          // 5. Footer Action Bar
          Container(
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
                  onPressed: canProceed ? () {
                    if (selectedMacroId == null && selectedAction != null) {
                      ref.read(macroActionsProvider.notifier).state = [
                        ActionItem()..payload = selectedAction
                      ];
                    }
                    context.go('/trigger/constraints');
                  } : null,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Proceed to Constraints",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

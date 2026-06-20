// import 'package:flutter/material.dart';
// import '../widgets/sequence_recorder_sheet.dart';
// import '../widgets/inpur_source_card.dart';
//
// class TriggerConfigScreen extends StatefulWidget {
//   const TriggerConfigScreen({super.key});
//
//   @override
//   State<TriggerConfigScreen> createState() => _TriggerConfigScreenState();
// }
//
// class _TriggerConfigScreenState extends State<TriggerConfigScreen> {
//   // Dummy state
//   String _profileName = "";
//   List<String> _sequence = [];
//   String _selectedLengthRule = "Single Press";
//   InputSource? _selectedSource;
//
//   void _openStudio(InputSource source) async {
//     setState(() => _selectedSource = source);
//     final result = await SequenceRecorderSheet.show(context, source);
//     if (result != null) {
//       setState(() {
//         _sequence = result;
//         if (_sequence.length > 1) {
//           _selectedLengthRule = "Sequence";
//         } else if (_sequence.length == 1) {
//           _selectedLengthRule = "Single Press";
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//     final textTheme = theme.textTheme;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Configure Trigger', style: TextStyle(fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // 1. Profile Name
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Profile Name',
//                   hintText: 'e.g., Media Controls',
//                   filled: true,
//                   fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(16),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//                 onChanged: (val) => setState(() => _profileName = val),
//               ),
//               const SizedBox(height: 32),
//
//               // 2. Input Sources
//               Text(
//                 'INPUT SOURCE',
//                 style: textTheme.labelMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: colorScheme.onSurfaceVariant,
//                   letterSpacing: 1.2,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   InputSourceCard(
//                     icon: Icons.keyboard_outlined,
//                     label: 'Keyboard',
//                     isSelected: _selectedSource == InputSource.keyboard,
//                     onTap: () => _openStudio(InputSource.keyboard),
//                   ),
//                   InputSourceCard(
//                     icon: Icons.smartphone,
//                     label: 'Phone',
//                     isSelected: _selectedSource == InputSource.phone,
//                     onTap: () => _openStudio(InputSource.phone),
//                   ),
//                   InputSourceCard(
//                     icon: Icons.gamepad_outlined,
//                     label: 'Gamepad',
//                     isSelected: _selectedSource == InputSource.gamepad,
//                     onTap: () => _openStudio(InputSource.gamepad),
//                   ),
//                   InputSourceCard(
//                     icon: Icons.headphones_outlined,
//                     label: 'Headset',
//                     isSelected: _selectedSource == InputSource.headset,
//                     onTap: () => _openStudio(InputSource.headset),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),
//
//               // 3. The Captured Sequence
//               if (_sequence.isNotEmpty) ...[
//                 Text(
//                   'CAPTURED SEQUENCE',
//                   style: textTheme.labelMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: colorScheme.onSurfaceVariant,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: colorScheme.surfaceContainerHighest,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     crossAxisAlignment: WrapCrossAlignment.center,
//                     children: _buildSequenceChips(colorScheme),
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//
//                 // 4. The "Length Rule" Action Selector
//                 Text(
//                   'TRIGGER ACTION',
//                   style: textTheme.labelMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: colorScheme.onSurfaceVariant,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 if (_sequence.length == 1)
//                   Wrap(
//                     spacing: 12,
//                     runSpacing: 12,
//                     children: ['Single Press', 'Double Press', 'Long Press', 'Triple Press'].map((type) {
//                       final isSelected = _selectedLengthRule == type;
//                       return ChoiceChip(
//                         label: Text(type),
//                         selected: isSelected,
//                         selectedColor: colorScheme.secondary,
//                         labelStyle: TextStyle(
//                           color: isSelected ? colorScheme.onSecondary : colorScheme.onSurface,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         onSelected: (selected) {
//                           if (selected) setState(() => _selectedLengthRule = type);
//                         },
//                       );
//                     }).toList(),
//                   )
//                 else
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [colorScheme.primaryContainer, colorScheme.secondaryContainer],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: colorScheme.primary.withOpacity(0.5), width: 2),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.hub, color: colorScheme.primary, size: 28),
//                         const SizedBox(width: 12),
//                         Text(
//                           'Trigger Type: Sequence',
//                           style: textTheme.titleMedium?.copyWith(
//                             fontWeight: FontWeight.bold,
//                             color: colorScheme.onPrimaryContainer,
//                             letterSpacing: 1.1,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//               ],
//             ],
//           ),
//         ),
//       ),
//       // 5. Save Button
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: FilledButton(
//             onPressed: _sequence.isEmpty ? null : () {},
//             style: FilledButton.styleFrom(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             ),
//             child: const Text('Save Automation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildSequenceChips(ColorScheme colorScheme) {
//     List<Widget> widgets = [];
//     for (int i = 0; i < _sequence.length; i++) {
//       widgets.add(
//         Chip(
//           label: Text(
//             '[ ${_sequence[i]} ]',
//             style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onTertiaryContainer),
//           ),
//           backgroundColor: colorScheme.tertiaryContainer,
//           side: BorderSide.none,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         )
//       );
//       if (i < _sequence.length - 1) {
//         widgets.add(
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4.0),
//             child: Icon(Icons.arrow_forward, color: colorScheme.onSurfaceVariant, size: 20),
//           )
//         );
//       }
//     }
//     return widgets;
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/sequence_recorder_sheet.dart';
import '../widgets/inpur_source_card.dart';
import 'package:go_router/go_router.dart';
import '../../../core/state/draft_profile_provider.dart';
import '../../../core/model/automation_profile.dart';

class TriggerConfigScreen extends ConsumerStatefulWidget {
  const TriggerConfigScreen({super.key});

  @override
  ConsumerState<TriggerConfigScreen> createState() => _TriggerConfigScreenState();
}

class _TriggerConfigScreenState extends ConsumerState<TriggerConfigScreen> {
  InputSource? _selectedSource;

  void _openStudio(InputSource source) async {
    setState(() => _selectedSource = source);
    final result = await SequenceRecorderSheet.show(context, source);
    if (result != null) {
      final sequence = result;
      String triggerType = "Single Press";
      if (sequence.length > 1) {
        triggerType = "Sequence";
      }

      final draft = ref.read(draftProfileProvider);
      if (draft != null) {
        ref.read(draftProfileProvider.notifier).state = draft.copyWith(
          triggerSequence: sequence,
          triggerType: triggerType,
        );
      } else {
        ref.read(draftProfileProvider.notifier).state = AutomationProfile(
          name: "",
          triggerType: triggerType,
          triggerSequence: sequence,
          isEnabled: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final draft = ref.watch(draftProfileProvider);
    final profileName = draft?.name ?? "";
    final sequence = draft?.triggerSequence ?? [];
    final selectedLengthRule = draft?.triggerType ?? "Single Press";

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text(
            'Configure Trigger', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Profile Name
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Profile Name',
                  hintText: 'e.g., Media Controls',
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.edit_note, color: colorScheme.primary),
                ),
                onChanged: (val) {
                  final draft = ref.read(draftProfileProvider);
                  if (draft != null) {
                    ref.read(draftProfileProvider.notifier).state = draft.copyWith(name: val);
                  } else {
                    ref.read(draftProfileProvider.notifier).state = AutomationProfile(
                      name: val,
                      triggerType: "Unknown",
                      triggerSequence: [],
                    );
                  }
                },
              ),
              const SizedBox(height: 32),

              // 2. Input Sources
              Text(
                'INPUT SOURCE',
                style: textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InputSourceCard(
                    icon: Icons.keyboard_outlined,
                    label: 'Keyboard',
                    isSelected: _selectedSource == InputSource.keyboard,
                    onTap: () => _openStudio(InputSource.keyboard),
                  ),
                  InputSourceCard(
                    icon: Icons.smartphone,
                    label: 'Phone',
                    isSelected: _selectedSource == InputSource.phone,
                    onTap: () => _openStudio(InputSource.phone),
                  ),
                  InputSourceCard(
                    icon: Icons.gamepad_outlined,
                    label: 'Gamepad',
                    isSelected: _selectedSource == InputSource.gamepad,
                    onTap: () => _openStudio(InputSource.gamepad),
                  ),
                  InputSourceCard(
                    icon: Icons.headphones_outlined,
                    label: 'Headset',
                    isSelected: _selectedSource == InputSource.headset,
                    onTap: () => _openStudio(InputSource.headset),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // 3. The Captured Sequence (Rendered as Macro Cards)
              if (sequence.isNotEmpty) ...[
                Text(
                  'CAPTURED SEQUENCE',
                  style: textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
                  ),
                  child: Column(
                    children: _buildSequenceCards(colorScheme, textTheme, sequence, selectedLengthRule),
                  ),
                ),
                const SizedBox(height: 32),

                // 4. The "Length Rule" Action Selector
                Text(
                  'TRIGGER ACTION',
                  style: textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                if (sequence.length == 1)
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      'Single Press',
                      'Double Press',
                      'Long Press',
                      'Triple Press'
                    ].map((type) {
                      final isSelected = selectedLengthRule == type;
                      return ChoiceChip(
                        label: Text(type),
                        selected: isSelected,
                        // Match the Save Automation button color
                        selectedColor: colorScheme.primary,
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        side: BorderSide.none,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? colorScheme.onPrimary
                              : colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                        onSelected: (selected) {
                          if (selected) {
                            final draft = ref.read(draftProfileProvider);
                            if (draft != null) {
                              ref.read(draftProfileProvider.notifier).state = draft.copyWith(triggerType: type);
                            }
                          }
                        },
                      );
                    }).toList(),
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.linear_scale,
                            color: colorScheme.onPrimaryContainer, size: 24),
                        const SizedBox(width: 12),
                        Text(
                          'Trigger Type: Sequence',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onPrimaryContainer,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
      // 5. Save Button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: FilledButton(
            onPressed: () {
              if (profileName.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Please enter a Profile name before continuing.'),
                    backgroundColor: colorScheme.error,
                  ),
                );
                return;
              }
              if (sequence.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Please capture an input sequence before continuing.'),
                    backgroundColor: colorScheme.error,
                  ),
                );
                return;
              }
              context.go('/trigger/action');
            },
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Save Automation',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

// Generates the new "Macro Card" look for the sequence
  List<Widget> _buildSequenceCards(ColorScheme colorScheme,
      TextTheme textTheme, List<String> sequence, String selectedLengthRule) {
    List<Widget> widgets = [];
    for (int i = 0; i < sequence.length; i++) {
      widgets.add(
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ],
              border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: colorScheme.primaryContainer,
                child: Icon(Icons.memory, color: colorScheme.primary, size: 20),
              ),
              title: Text(
                sequence[i],
                style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Hardware Input ${i + 1}', style: textTheme.bodySmall),
              // THE FIX: Added a delete button with State re-evaluation
              trailing: IconButton(
                icon: Icon(Icons.remove_circle_outline,
                    color: colorScheme.error.withValues(alpha: 0.8)),
                tooltip: 'Remove input',
                onPressed: () {
                  // 1. Remove the item from the list
                  final newList = List<String>.from(sequence);
                  newList.removeAt(i);
                  
                  final draft = ref.read(draftProfileProvider);
                  if (draft != null) {
                    // 2. Re-evaluate the Length Rule dynamically
                    String newTriggerType = draft.triggerType;
                    if (newList.length == 1) {
                      newTriggerType = "Single Press";
                    } else if (newList.isEmpty) {
                      newTriggerType = "Unknown";
                    }
                    
                    ref.read(draftProfileProvider.notifier).state = draft.copyWith(
                      triggerSequence: newList,
                      triggerType: newTriggerType,
                    );
                  }
                },
              ),
            ),
          )
      );
    }
    return widgets;
  }
}
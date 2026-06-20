import 'package:isar/isar.dart';

part 'action_item.g.dart';

@embedded
class ActionItem {
  // Core Data
  String? actionType; // e.g., "keyboard", "mouse", "shell"
  String? payload;    // e.g., "Ctrl+C" or a bash script snippet

  // UI Display overrides (Optional, if the user renames the action in the UI)
  String? customTitle;
  String? customSubtitle;
  String? customTagLabel;

  // Execution modifiers
  int delayMs = 0; // The delay pill in the UI
  int repeatCount = 1;  // The inline repetition counter
}
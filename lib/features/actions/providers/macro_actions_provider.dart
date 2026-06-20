import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/model/action_item.dart';

class MacroActionsNotifier extends StateNotifier<List<ActionItem>> {
  MacroActionsNotifier() : super([]);

  void addAction(ActionItem item) {
    state = [...state, item];
  }

  void removeAction(int index) {
    final newState = List<ActionItem>.from(state);
    newState.removeAt(index);
    state = newState;
  }

  void updateActionIteration(int index, int newRepeatCount, int newDelayMs) {
    final newState = List<ActionItem>.from(state);
    final item = newState[index];
    
    // We create a new ActionItem or mutate the existing one?
    // Since ActionItem is an Isar embedded object, we can mutate its fields, but we must reassign state to trigger UI update.
    item.repeatCount = newRepeatCount;
    item.delayMs = newDelayMs;
    
    state = newState;
  }
  
  void reorderActions(int oldIndex, int newIndex) {
    final newState = List<ActionItem>.from(state);
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = newState.removeAt(oldIndex);
    newState.insert(newIndex, item);
    state = newState;
  }
  
  void clear() {
    state = [];
  }
}

final macroActionsProvider = StateNotifierProvider<MacroActionsNotifier, List<ActionItem>>((ref) {
  return MacroActionsNotifier();
});

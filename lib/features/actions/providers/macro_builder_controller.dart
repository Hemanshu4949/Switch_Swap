import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/model/macro.dart';
import '../../../core/model/action_item.dart';
import '../../../core/providers/database_provider.dart';

part 'macro_builder_controller.g.dart';

@riverpod
class MacroBuilderController extends _$MacroBuilderController {
  @override
  Macro build() {
    return Macro(name: '', isStandalone: true);
  }

  Macro _cloneState() {
    return Macro(
      id: state.id,
      name: state.name,
      actions: List<ActionItem>.from(state.actions),
      isLoopActive: state.isLoopActive,
      repeatCount: state.repeatCount,
      isStandalone: state.isStandalone,
    );
  }

  void updateName(String name) {
    state = _cloneState()..name = name;
  }

  void addAction(ActionItem action) {
    final newState = _cloneState();
    newState.actions.add(action);
    state = newState;
  }

  void removeAction(int index) {
    final newState = _cloneState();
    newState.actions.removeAt(index);
    state = newState;
  }

  void reorderActions(int oldIndex, int newIndex) {
    final newState = _cloneState();
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = newState.actions.removeAt(oldIndex);
    newState.actions.insert(newIndex, item);
    state = newState;
  }

  void incrementActionRepeat(int index) {
    final newState = _cloneState();
    newState.actions[index].repeatCount += 1;
    state = newState;
  }

  void decrementActionRepeat(int index) {
    final newState = _cloneState();
    if (newState.actions[index].repeatCount > 1) {
      newState.actions[index].repeatCount -= 1;
      state = newState;
    }
  }

  void updateActionDelay(int index, int delayMs) {
    final newState = _cloneState();
    newState.actions[index].delayMs = delayMs;
    state = newState;
  }

  Future<void> saveMacro() async {
    final isarService = ref.read(isarServiceProvider);
    await isarService.saveMacro(state);
    state = build();
  }

  void toggleLoop(bool value) {
    final newState = _cloneState();
    newState.isLoopActive = value;
    state = newState;
  }

  void incrementGlobalRepeat() {
    final newState = _cloneState();
    newState.repeatCount += 1;
    state = newState;
  }

  void decrementGlobalRepeat() {
    final newState = _cloneState();
    if (newState.repeatCount > 1) {
      newState.repeatCount -= 1;
      state = newState;
    }
  }
}

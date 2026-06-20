// 1. Update the State Object
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../model/trigger_enums.dart';
part 'trigger_config_provider.g.dart';


class TriggerConfigState {
  final InputSource selectedSource;
  final TriggerAction selectedAction;
  final String? capturedKey; // ADD THIS

  TriggerConfigState({
    required this.selectedSource,
    required this.selectedAction,
    this.capturedKey, // ADD THIS
  });

  TriggerConfigState copyWith({
    InputSource? selectedSource,
    TriggerAction? selectedAction,
    String? capturedKey, // ADD THIS
  }) {
    return TriggerConfigState(
      selectedSource: selectedSource ?? this.selectedSource,
      selectedAction: selectedAction ?? this.selectedAction,
      capturedKey: capturedKey ?? this.capturedKey, // ADD THIS
    );
  }
}

// 2. Update the Notifier
@riverpod
class TriggerConfig extends _$TriggerConfig {
  @override
  TriggerConfigState build() {
    return TriggerConfigState(
      selectedSource: InputSource.keyboard,
      selectedAction: TriggerAction.longPress,
      capturedKey: null, // Starts null because nothing is pressed yet
    );
  }

  void setSource(InputSource source) {
    state = state.copyWith(selectedSource: source);
  }

  void setAction(TriggerAction action) {
    state = state.copyWith(selectedAction: action);
  }

  // 3. Add the Microphone Receiver
  void captureKey(String keyLabel) {
    // Only capture if it's a valid key
    if (keyLabel.isNotEmpty) {
      state = state.copyWith(capturedKey: keyLabel.toUpperCase());
    }
  }
}
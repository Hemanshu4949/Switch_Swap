import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../model/key_map.dart';
import '../engine/trigger_matcher_service.dart';

// 1. The State Object
class HomeState {
  final bool isMasterActive;
  final List<KeyMapModel> activeMappings;

  HomeState({
    required this.isMasterActive,
    required this.activeMappings,
  });

  // copyWith allows us to create a new state object with only specific fields changed.
  // This is required because Riverpod relies on IMMUTABLE state to trigger UI updates.
  HomeState copyWith({
    bool? isMasterActive,
    List<KeyMapModel>? activeMappings,
  }) {
    return HomeState(
      isMasterActive: isMasterActive ?? this.isMasterActive,
      activeMappings: activeMappings ?? this.activeMappings,
    );
  }
}

// 2. The Notifier (Business Logic)
class HomeStateNotifier extends Notifier<HomeState> {
  @override
  HomeState build() {
    // This replaces initState(). We return the starting data.
    return HomeState(
      isMasterActive: true,
      activeMappings: [
        KeyMapModel(
          id: '1',
          keys: ['CTRL', 'SHIFT', 'T'],
          iconLeft: Icons.keyboard_alt_outlined,
          iconRight: Icons.terminal_outlined,
          title: 'Launch Dev Terminal',
          subtitle: 'Global Scope',
        ),
        KeyMapModel(
          id: '2',
          keys: ['CAPS LOCK'],
          iconLeft: Icons.keyboard_capslock_outlined,
          iconRight: Icons.keyboard_outlined,
          title: 'Remap to Escape',
          subtitle: 'Vim Mode active',
        ),
        KeyMapModel(
          id: '3',
          keys: ['ALT', 'M'],
          iconLeft: Icons.mic_none_outlined,
          iconRight: Icons.mic_off_outlined,
          title: 'Mute System Audio',
          subtitle: 'Conflict with Discord',
          isError: true,
        ),
      ],
    );
  }

  // 3. Methods to update state
  void toggleMaster(bool newValue) {
    state = state.copyWith(isMasterActive: newValue);
    
    // Toggle the actual background service
    if (TriggerMatcherService.instance != null) {
      if (newValue) {
        TriggerMatcherService.instance!.start();
      } else {
        TriggerMatcherService.instance!.stop();
      }
    }
  }

  void toggleMacro(int index, bool newValue) {
    // Create a fresh copy of the list to ensure Riverpod detects the change
    final newList = List<KeyMapModel>.from(state.activeMappings);

    // Update the specific item
    final updatedItem = newList[index];
    updatedItem.isActive = newValue;
    newList[index] = updatedItem;

    // Push the new state
    state = state.copyWith(activeMappings: newList);
  }
}

// 4. The Global Provider (How the UI accesses the Notifier)
final homeProvider = NotifierProvider<HomeStateNotifier, HomeState>(() {
  return HomeStateNotifier();
});
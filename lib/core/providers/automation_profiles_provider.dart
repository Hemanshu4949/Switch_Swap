import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../model/automation_profile.dart';
import '../model/macro.dart';
import 'database_provider.dart';

class AutomationProfilesNotifier extends Notifier<List<AutomationProfile>> {
  @override
  List<AutomationProfile> build() {
    // SYNCHRONOUS BOOT FIX:
    // Read the database synchronously using the initialized provider
    final isar = Isar.getInstance()!;
    // findAllSync() populates the initial state synchronously, preventing empty UI
    final profiles = isar.automationProfiles.where().findAllSync();
    for (var p in profiles) {
      p.macro.loadSync();
    }
    return profiles;
  }

  void addProfile(AutomationProfile newProfile, Macro linkedMacro) {
    final isar = Isar.getInstance()!;
    
    isar.writeTxnSync(() {
      // 1. Save the macro first
      isar.macros.putSync(linkedMacro);
      // 2. Save the profile
      isar.automationProfiles.putSync(newProfile);
      // 3. Attach and save link
      newProfile.macro.value = linkedMacro;
      newProfile.macro.saveSync();
    });
    
    newProfile.macro.loadSync();
    
    state = [...state, newProfile];
  }

  void toggleProfileState(Id profileId, bool isEnabled) {
    final isar = Isar.getInstance()!;
    
    // Find the profile in Isar
    final profile = isar.automationProfiles.getSync(profileId);
    
    if (profile != null) {
      profile.isEnabled = isEnabled;
      
      // Execute isar.writeTxnSync to put the updated profile
      isar.writeTxnSync(() {
        isar.automationProfiles.putSync(profile);
      });
      
      profile.macro.loadSync();
      
      // Update the specific item in the state list
      state = state.map((p) => p.id == profileId ? profile : p).toList();
    }
  }

  void deleteProfile(Id profileId) {
    final isar = Isar.getInstance()!;
    
    // Delete from Isar
    isar.writeTxnSync(() {
      isar.automationProfiles.deleteSync(profileId);
    });
    
    // Remove from the state list
    state = state.where((p) => p.id != profileId).toList();
  }
}

final automationProfilesProvider =
    NotifierProvider<AutomationProfilesNotifier, List<AutomationProfile>>(() {
  return AutomationProfilesNotifier();
});

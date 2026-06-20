import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../model/automation_profile.dart';
import '../model/macro.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      // Ensure both schemas are registered
      return await Isar.open(
        [AutomationProfileSchema, MacroSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  // ==========================================
  // MACRO CRUD OPERATIONS
  // ==========================================

  Future<int> saveMacro(Macro newMacro) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      return await isar.macros.put(newMacro);
    });
  }

  Future<List<Macro>> getAllMacros() async {
    final isar = await db;
    return await isar.macros.where().findAll();
  }

  Future<void> deleteMacro(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      // Isar handles relational orphan cleanup automatically:
      // any Profile pointing to this Macro will just end up with an empty link.
      await isar.macros.delete(id);
    });
  }

  // ==========================================
  // PROFILE CRUD OPERATIONS
  // ==========================================

  Future<void> saveProfileWithMacro(AutomationProfile profile, Macro linkedMacro) async {
    final isar = await db;
    
    await isar.writeTxn(() async {
      // 1. Put the macro first
      await isar.macros.put(linkedMacro);
      
      // 2. Put the profile
      await isar.automationProfiles.put(profile);
      
      // 3. Attach the linked macro instance
      profile.macro.value = linkedMacro;
      
      // 4. Save the relational link to the DB
      await profile.macro.save();
    });
  }
  
  Future<List<AutomationProfile>> getAllProfiles() async {
    final isar = await db;
    return await isar.automationProfiles.where().findAll();
  }
}

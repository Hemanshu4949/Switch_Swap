import 'package:isar/isar.dart';
import 'lib/core/model/automation_profile.dart';
import 'lib/core/model/macro.dart';

void main() async {
  await Isar.initializeIsarCore(download: true);
  final isar = await Isar.open([AutomationProfileSchema, MacroSchema], directory: '.');
  await isar.writeTxn(() async {
    await isar.clear();
  });
  print("Database wiped.");
}

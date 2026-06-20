import 'package:isar/isar.dart';

part 'execution_constraints.g.dart';

@embedded
class ExecutionConstraints {
  bool requireScreenOn = false;
  bool requireDeviceUnlocked = false;
  
  // Optional: Only run if a specific app is in the foreground
  String? requireSpecificAppOpen; 
}

import 'package:isar/isar.dart';

part 'trigger.g.dart';

@embedded
class Trigger {
  String? id;
  String? triggerType; // e.g., "KeyPress", "Bluetooth", "AppLaunch"
  String? value;       // e.g., "VolumeUp", "My_AirPods", "com.spotify"
}

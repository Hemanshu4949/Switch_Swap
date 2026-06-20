import 'package:isar/isar.dart';
import 'macro.dart';

part 'automation_profile.g.dart';

@embedded
class ExecutionConstraints {
  bool requireScreenOn = false;
  bool requireDeviceUnlocked = false;
  bool requireLandscape = false;
  bool requireCharging = false;
  bool requireWiFi = false;
  bool requireHeadset = false;
  String? requireSpecificApp;
}

@Collection()
class AutomationProfile {
  Id id = Isar.autoIncrement;
  
  late String name;
  late String triggerType;
  late List<String> triggerSequence;
  late bool isEnabled;

  ExecutionConstraints? constraints;

  // The relational link pointing to our new Macro collection
  final macro = IsarLink<Macro>();

  AutomationProfile({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.triggerType,
    this.triggerSequence = const [],
    this.isEnabled = true,
    this.constraints,
  });

  AutomationProfile copyWith({
    Id? id,
    String? name,
    String? triggerType,
    List<String>? triggerSequence,
    bool? isEnabled,
    ExecutionConstraints? constraints,
  }) {
    return AutomationProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      triggerType: triggerType ?? this.triggerType,
      triggerSequence: triggerSequence ?? this.triggerSequence,
      isEnabled: isEnabled ?? this.isEnabled,
      constraints: constraints ?? this.constraints,
    );
  }
}

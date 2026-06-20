import 'package:isar/isar.dart';
import 'action_item.dart';

part 'macro.g.dart';

@Collection()
class Macro {
  Id id = Isar.autoIncrement;
  
  late String name;
  List<ActionItem> actions = [];
  bool isLoopActive = false;
  int repeatCount = 1;
  bool isStandalone = false;

  Macro({
    this.id = Isar.autoIncrement,
    required this.name,
    this.actions = const [],
    this.isLoopActive = false,
    this.repeatCount = 1,
    this.isStandalone = false,
  });

  Macro copyWith({
    Id? id,
    String? name,
    List<ActionItem>? actions,
    bool? isLoopActive,
    int? repeatCount,
    bool? isStandalone,
  }) {
    return Macro(
      id: id ?? this.id,
      name: name ?? this.name,
      actions: actions ?? this.actions,
      isLoopActive: isLoopActive ?? this.isLoopActive,
      repeatCount: repeatCount ?? this.repeatCount,
      isStandalone: isStandalone ?? this.isStandalone,
    );
  }
}

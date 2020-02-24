import 'package:hive/hive.dart';

part 'movement_type.g.dart';

@HiveType(typeId: 1)
enum MovementType {
  @HiveField(0)
  DEPOSIT,

  @HiveField(1)
  WITHDRAW
}
import 'package:cofrinho_piggy_bank/app/shared/models/movement_type.dart';
import 'package:hive/hive.dart';

part 'movement.g.dart';

@HiveType(typeId: 0)
class Movement {
  @HiveField(0)
  MovementType type;

  @HiveField(1)
  double value;

  @HiveField(2)
  DateTime dateTime;

  Movement({this.type, this.value, this.dateTime});
}
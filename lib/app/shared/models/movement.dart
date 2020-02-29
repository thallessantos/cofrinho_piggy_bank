import 'package:cofrinho_piggy_bank/app/shared/models/coin.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/movement_type.dart';
import 'package:hive/hive.dart';

part 'movement.g.dart';

@HiveType(typeId: 0)
class Movement {
  @HiveField(0)
  MovementType type;

  @HiveField(1)
  Coin coin;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  DateTime dateTime;

  @HiveField(4)
  bool breakingPiggyBank;

  Movement({this.type, this.coin, this.quantity, this.dateTime, this.breakingPiggyBank = false});
}
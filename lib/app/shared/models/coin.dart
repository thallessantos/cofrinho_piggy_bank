import 'package:hive/hive.dart';

part 'coin.g.dart';

@HiveType(typeId: 2)
class Coin {
  @HiveField(0)
  double value;

  @HiveField(1)
  String imageName;

  @HiveField(2)
  double imageSize;

  @HiveField(3)
  int count;

  Coin({this.value, this.imageName, this.imageSize, this.count});
}
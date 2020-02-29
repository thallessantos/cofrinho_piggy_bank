import 'package:cofrinho_piggy_bank/app/shared/models/movement.dart';

abstract class ILocalStorage {
  static final String kDbName = "DB";
  static final String kAmountKey = "AMOUNT";
  static final String kCurrencyKey = "CURRENCY";
  static final String kMovementsKey = "MOVEMENTS";
  static final String kLastMovementIndexKey = "LAST_MOVEMENT_INDEX";
  static const int kMovementsPageCount = 20;

  Future<double> getAmount();
  Future putAmount(double value);

  Future<int> getCoinCount(String key);
  Future putCoinCount(String key, int value);

  Future<String> getCurrency();
  Future putCurrency(String value);

  Future<dynamic> getData(String key);
  Future putData(String key, dynamic value);

  Future<List<Movement>> getMovements({int startIndex, int count = kMovementsPageCount, bool desc = false});
  Future addMovement(Movement value);
  Future<int> getLastMovementIndex();
}
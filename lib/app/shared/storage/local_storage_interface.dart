import 'package:cofrinho_piggy_bank/app/shared/models/movement.dart';

abstract class ILocalStorage {
  static final String kDbName = "DB";
  static final String kAmountKey = "AMOUNT";
  static final String kMovementKey = "MOVEMENTS";
  static final String kCurrencyKey = "CURRENCY";

  Future<double> getAmount();
  Future putAmount(double value);

  Future<int> getCoinCount(String key);
  Future putCoinCount(String key, int value);

  Future<List<Movement>> getMovements();
  Future putMovements(List<Movement> value);

  Future<String> getCurrency();
  Future putCurrency(String value);

  Future<dynamic> getData(String key);
  Future putData(String key, dynamic value);
}
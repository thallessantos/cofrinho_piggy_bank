import 'dart:async';

import 'package:cofrinho_piggy_bank/app/shared/models/movement.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/movement_type.dart';
import 'package:cofrinho_piggy_bank/app/shared/storage/local_storage_interface.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageHive implements ILocalStorage {
  Completer<Box> _instance = Completer<Box>();

  LocalStorageHive() {
    _init();
  }

  _init() async {
    var appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);
    Hive.registerAdapter<Movement>(MovementAdapter());
    Hive.registerAdapter<MovementType>(MovementTypeAdapter());
    _instance.complete(await Hive.openBox(ILocalStorage.kDbName));
  }

  @override
  Future<double> getAmount() async {
    var box = await _instance.future;
    return box.get(ILocalStorage.kAmountKey);
  }

  @override
  Future putAmount(double value) async {
    var box = await _instance.future;
    box.put(ILocalStorage.kAmountKey, value);
  }

  @override
  Future<int> getCoinCount(String key) async {
    var box = await _instance.future;
    return box.get(key);
  }

  @override
  Future putCoinCount(String key, int value) async {
    var box = await _instance.future;
    box.put(key, value);
  }

  @override
  Future<List<Movement>> getMovements() async {
    var box = await _instance.future;
    List<dynamic> list = box.get(ILocalStorage.kMovementKey);
    if (list != null)
      return list.cast<Movement>();
    return <Movement>[];
  }

  @override
  Future putMovements(List<Movement> value) async {
    var box = await _instance.future;
    box.put(ILocalStorage.kMovementKey, value);
  }

  @override
  Future<String> getCurrency() async {
    var box = await _instance.future;
    return box.get(ILocalStorage.kCurrencyKey);
  }

  @override
  Future putCurrency(String value) async {
    var box = await _instance.future;
    box.put(ILocalStorage.kCurrencyKey, value);
  }

  @override
  Future getData(String key) async {
    var box = await _instance.future;
    return box.get(key);
  }

  @override
  Future putData(String key, value) async {
    var box = await _instance.future;
    box.put(key, value);
  }

}
import 'dart:async';

import 'package:cofrinho_piggy_bank/app/shared/models/coin.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/movement.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/movement_type.dart';
import 'package:cofrinho_piggy_bank/app/shared/storage/local_storage_interface.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageHive implements ILocalStorage {
  Completer<Box> _instance = Completer<Box>();
  Completer<Box> _instanceMovements = Completer<Box>();

  LocalStorageHive() {
    _init();
  }

  _init() async {
    var appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);
    Hive.registerAdapter<Movement>(MovementAdapter());
    Hive.registerAdapter<MovementType>(MovementTypeAdapter());
    Hive.registerAdapter<Coin>(CoinAdapter());
    _instance.complete(await Hive.openBox(ILocalStorage.kDbName));
    _instanceMovements.complete(await Hive.openBox(ILocalStorage.kMovementsKey));
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

  @override
  Future<List<Movement>> getMovements({int startIndex, int count = 20, bool desc = false}) async {
    var box = await _instanceMovements.future;
    List<Movement> movementList = <Movement>[];
    if (!desc) {
      for (int i = startIndex ?? 0; i < count; i++) {
        Movement movement = box.get(i);
        if (movement != null)
          movementList.add(movement);
        else
          return movementList;
      }
    } else {
      if (startIndex == null)
        startIndex = (await getLastMovementIndex()) ?? -1;
      for (int i = startIndex; i >= 0 && i > (startIndex - count); i--) {
        Movement movement = box.get(i);
        if (movement != null)
          movementList.add(movement);
        else
          continue;
      }
    }
    return movementList;
  }

  @override
  Future addMovement(Movement movement) async {
    var box = await _instanceMovements.future;
    int lastMovementIndex = (await getLastMovementIndex()) ?? -1;
    lastMovementIndex++;
    box.put(lastMovementIndex, movement);
    putData(ILocalStorage.kLastMovementIndexKey, lastMovementIndex);
  }

  @override
  Future<int> getLastMovementIndex() async {
    var box = await _instance.future;
    return box.get(ILocalStorage.kLastMovementIndexKey);
  }
}
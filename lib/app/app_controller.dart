import 'package:cofrinho_piggy_bank/app/shared/app_utils.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/coin.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/movement.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/movement_type.dart';
import 'package:cofrinho_piggy_bank/app/shared/services/coin_service.dart';
import 'package:cofrinho_piggy_bank/app/shared/storage/local_storage_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController = _AppBase with _$AppController;

abstract class _AppBase with Store {
  ILocalStorage _storage;
  CoinService _coinService;

  _AppBase({ILocalStorage storage, CoinService coinService}) {
    _storage = storage ?? Modular.get();
    _coinService = coinService ?? Modular.get();

    init();
  }

  @observable
  String currency;

  @observable
  double amount = 0;

  @observable
  ObservableList<Coin> coins = <Coin>[].asObservable();

  @action
  init() async {
    currency = await _storage.getCurrency();
    if (currency == null)
      await updateCurrency(BRL);
    amount = await _storage.getAmount() ?? 0;
    coins = (await _coinService.getUpdatedCoins(currency)).asObservable();
  }

  @action
  Future updateCurrency(String newCurrency) async {
    currency = newCurrency;
    return _storage.putCurrency(newCurrency);
  }

  @action
  Future _updateAmount(double newAmount) async {
    amount = newAmount;
    return _storage.putAmount(newAmount);
  }

  Future decreaseAmount(double toDecrease) async => _updateAmount(amount -= toDecrease);
  Future increaseAmount(double toIncrease) async => _updateAmount(amount += toIncrease);

  Future increaseCoinCount(Coin coin, int quantity) async {
    coin.count = (coin.count ?? 0) + quantity;
    await _updateCoinCount(coin);
    return _addMovement(MovementType.DEPOSIT, coin, quantity);
  }

  Future decreaseCoinCount(Coin coin, int quantity) async {
    coin.count = (coin.count ?? 0) - quantity;
    await _updateCoinCount(coin);
    return _addMovement(MovementType.WITHDRAW, coin, quantity);
  }

  @action
  Future _updateCoinCount(Coin coin) async {
    return _storage.putCoinCount(_coinService.getCoinCountKey(coin), coin.count);
  }

  Future _addMovement(MovementType type, Coin coin, int quantity) async {
    return _storage.addMovement(Movement(type: type, coin: coin, quantity: quantity, dateTime: DateTime.now()));
  }
}
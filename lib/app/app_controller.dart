import 'package:cofrinho_piggy_bank/app/shared/app_utils.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/coin.dart';
import 'package:cofrinho_piggy_bank/app/shared/services/coin_service.dart';
import 'package:cofrinho_piggy_bank/app/shared/storage/local_storage_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController = _AppBase with _$AppController;

abstract class _AppBase with Store {
  final ILocalStorage _storage = Modular.get();
  final CoinService _coinService = Modular.get();

  @observable
  String currency;

  @observable
  double amount = 0;

  @observable
  ObservableList<Coin> coins = <Coin>[].asObservable();

  _AppBase() {
    init();
  }

  @action
  init() async {
    currency = await _storage.getCurrency();
    if (currency == null)
      await updateCurrency(BRL);
    amount = await _storage.getAmount() ?? 0;
    coins = (await _coinService.getUpdatedCoins(currency)).asObservable();
  }

  @action
  updateCurrency(String newCurrency) async {
    await _storage.putCurrency(newCurrency);
    currency = newCurrency;
  }

  @action
  updateAmount(double newAmount) async {
    await _storage.putAmount(newAmount);
    amount = newAmount;
  }

  decreaseAmount(double toDecrease) {
    updateAmount(amount -= toDecrease);
  }

  increaseAmount(double toIncrease) {
    updateAmount(amount += toIncrease);
  }
}

import 'package:cofrinho_piggy_bank/app/shared/models/coin.dart';
import 'package:cofrinho_piggy_bank/app/shared/services/coin_service.dart';
import 'package:cofrinho_piggy_bank/app/shared/storage/local_storage_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
  final ILocalStorage _storage = Modular.get();
  final CoinService _coinService = Modular.get();

  @observable
  double amount = 0;

  @observable
  ObservableList<Coin> coins = <Coin>[].asObservable();

  _HomeBase() {
    getData();
  }

  @action
  getData() async {
    amount = await _storage.getAmount() ?? 0;
    coins = (await _coinService.getUpdatedCoins()).asObservable();
  }
}

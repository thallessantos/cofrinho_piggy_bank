import 'package:cofrinho_piggy_bank/app/app_controller.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/coin.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'withdraw_controller.g.dart';

class WithdrawController = _WithdrawBase with _$WithdrawController;

abstract class _WithdrawBase with Store {

  @action
  Future<bool> decreaseAmount(Coin coin, {int quantity = 1}) async {
    if (quantity > (coin.count ?? 0))
      return false;

    AppController appController = Modular.get();
    await appController.decreaseAmount(coin.value * quantity);
    await appController.decreaseCoinCount(coin, quantity);
    return true;
  }
}

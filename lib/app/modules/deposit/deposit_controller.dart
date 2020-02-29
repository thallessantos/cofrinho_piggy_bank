import 'package:cofrinho_piggy_bank/app/app_controller.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/coin.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'deposit_controller.g.dart';

class DepositController = _DepositBase with _$DepositController;

abstract class _DepositBase with Store {
  @action
  increaseAmount(Coin coin, {int quantity = 1}) async {
    final AppController appController = Modular.get();
    await appController.increaseAmount(coin.value * quantity);
    await appController.increaseCoinCount(coin, quantity);
  }
}

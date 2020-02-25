import 'package:cofrinho_piggy_bank/app/app_controller.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/coin.dart';
import 'package:cofrinho_piggy_bank/app/shared/services/coin_service.dart';
import 'package:cofrinho_piggy_bank/app/shared/storage/local_storage_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'withdraw_controller.g.dart';

class WithdrawController = _WithdrawBase with _$WithdrawController;

abstract class _WithdrawBase with Store {
  final ILocalStorage _storage = Modular.get();
  final CoinService _coinService = Modular.get();

  @action
  Future<bool> decreaseAmount(Coin coin, {int quantity = 1}) async {
    if (quantity > (coin.count ?? 0))
      return false;

    Modular.get<AppController>().decreaseAmount(coin.value * quantity);

    coin.count = coin.count == null ? quantity : coin.count - quantity;
    _storage.putCoinCount(_coinService.getCoinCountKey(coin), coin.count);

    // List<Movement> movements = await _storage.getMovements();
    // if (movements == null) movements = List<Movement>();
    // movements.add(Movement(type: MovementType.WITHDRAW, value: amountToDecrease, dateTime: DateTime.now()));
    // _storage.putMovements(movements);
    return true;
  }
}

import 'package:cofrinho_piggy_bank/app/app_controller.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/coin.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/movement.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/movement_type.dart';
import 'package:cofrinho_piggy_bank/app/shared/services/coin_service.dart';
import 'package:cofrinho_piggy_bank/app/shared/storage/local_storage_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'deposit_controller.g.dart';

class DepositController = _DepositBase with _$DepositController;

abstract class _DepositBase with Store {
  final ILocalStorage _storage = Modular.get();
  final CoinService _coinService = Modular.get();

  @action
  increaseAmount(Coin coin, {int quantity = 1}) async {
    Modular.get<AppController>().increaseAmount(coin.value * quantity);

    coin.count = coin.count == null ? quantity : coin.count + quantity;
    _storage.putCoinCount(_coinService.getCoinCountKey(coin), coin.count);

    // List<Movement> movements = await _storage.getMovements();
    // if (movements == null) movements = List<Movement>();
    // movements.add(Movement(type: MovementType.DEPOSIT, value: amountToIncrease, dateTime: DateTime.now()));
    // _storage.putMovements(movements);
  }
}

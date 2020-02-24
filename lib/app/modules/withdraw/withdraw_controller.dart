import 'package:cofrinho_piggy_bank/app/shared/models/coin.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/movement.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/movement_type.dart';
import 'package:cofrinho_piggy_bank/app/shared/services/coin_service.dart';
import 'package:cofrinho_piggy_bank/app/shared/storage/local_storage_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'withdraw_controller.g.dart';

class WithdrawController = _WithdrawBase with _$WithdrawController;

abstract class _WithdrawBase with Store {
  final ILocalStorage _storage = Modular.get();
  final CoinService _coinService = Modular.get();

  @observable
  double amount = 0;

  @observable
  ObservableList<Coin> coins = <Coin>[].asObservable();

  _WithdrawBase() {
    init();
  }

  @action
  init() async {
    amount = await _storage.getAmount() ?? 0;
    coins = (await _coinService.getUpdatedCoins()).asObservable();
  }

  @action
  Future<bool> decreaseAmount(Coin coin, {int quantity = 1}) async {
    if (quantity > (coin.count ?? 0))
      return false;

    double amountToDecrease = coin.value * quantity;
    _storage.putAmount(amount - amountToDecrease);

    coin.count = coin.count == null ? quantity : coin.count - quantity;
    _storage.putCoinCount(_coinService.getCoinCountKey(coin), coin.count);

    List<Movement> movements = await _storage.getMovements();
    if (movements == null) movements = List<Movement>();
    movements.add(Movement(type: MovementType.WITHDRAW, value: amountToDecrease, dateTime: DateTime.now()));
    _storage.putMovements(movements);

    amount -= amountToDecrease;
    return true;
  }
}

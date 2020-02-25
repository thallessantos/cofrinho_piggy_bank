import 'package:cofrinho_piggy_bank/app/app_controller.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/coin.dart';
import 'package:cofrinho_piggy_bank/app/shared/storage/local_storage_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoinService {
  static final kOneCentCoinAvailable = "ONE_CENT_COIN_AVAILABLE";
  static final kTwoCentsCoinAvailable = "TWO_CENTS_COIN_AVAILABLE";

  List<Coin> _coins = [];
  List<Coin> get coins => _coins;

  final ILocalStorage _storage = Modular.get();

  Future initCoinsList(String currency) async {
    _coins.add(Coin(value: .05, imageName: "${currency}_005.png", imageSize: 50));
    _coins.add(Coin(value: .1, imageName: "${currency}_010.png", imageSize: 55));
    _coins.add(Coin(value: .25, imageName: "${currency}_025.png", imageSize: 60));
    _coins.add(Coin(value: .5, imageName: "${currency}_050.png", imageSize: 65));
    _coins.add(Coin(value: 1, imageName: "${currency}_100.png", imageSize: 70));
    return Future.wait(_coins.map((c) async {
      c.count = await _storage.getCoinCount(getCoinCountKey(c)) ?? 0;
    }));
  }

  Future<List<Coin>> getUpdatedCoins(String currency) async {
    if (_coins.length == 0)
      await initCoinsList(currency);
    else
      await Future.wait(_coins.map((c) async {
        c.count = await _storage.getCoinCount(getCoinCountKey(c)) ?? 0;
      }));
    return _coins;
  }

  String getCoinCountKey(Coin coin) {
    return "COIN_${coin.value}";
  }
}
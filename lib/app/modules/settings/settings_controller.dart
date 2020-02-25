import 'package:cofrinho_piggy_bank/app/shared/app_utils.dart';
import 'package:cofrinho_piggy_bank/app/shared/storage/local_storage_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'settings_controller.g.dart';

class SettingsController = _SettingsBase with _$SettingsController;

abstract class _SettingsBase with Store {
  final ILocalStorage _storage = Modular.get();
  List<String> currencyList = AppUtils.currencyList;

  @observable
  String selectedCurrency;

  _SettingsBase() {
    init();
  }

  @action
  init() async {
    selectedCurrency = await _storage.getCurrency();
  }

  @action
  changeCurrency(String currency) async {
    await _storage.putCurrency(currency);
    selectedCurrency = currency;
  }
}

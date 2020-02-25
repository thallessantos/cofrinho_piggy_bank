import 'package:cofrinho_piggy_bank/app/app_controller.dart';
import 'package:cofrinho_piggy_bank/app/modules/deposit/deposit_module.dart';
import 'package:cofrinho_piggy_bank/app/modules/settings/settings_module.dart';
import 'package:cofrinho_piggy_bank/app/modules/withdraw/withdraw_module.dart';
import 'package:cofrinho_piggy_bank/app/shared/services/coin_service.dart';
import 'package:cofrinho_piggy_bank/app/shared/storage/local_storage_hive.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:cofrinho_piggy_bank/app/app_widget.dart';
import 'package:cofrinho_piggy_bank/app/modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
    Bind((i) => AppController()),
    Bind((i) => LocalStorageHive()),
    Bind((i) => CoinService()),
  ];

  @override
  List<Router> get routers => [
    Router('/', module: HomeModule()),
    Router('/settings', module: SettingsModule(), transition: TransitionType.fadeIn),
    Router('/deposit', module: DepositModule(), transition: TransitionType.fadeIn),
    Router('/withdraw', module: WithdrawModule(), transition: TransitionType.fadeIn),
  ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}

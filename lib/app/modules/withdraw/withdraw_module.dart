import 'package:cofrinho_piggy_bank/app/modules/withdraw/withdraw_controller.dart';
import 'package:cofrinho_piggy_bank/app/modules/withdraw/withdraw_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WithdrawModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => WithdrawController()),
      ];

  @override
  List<Router> get routers => [
    Router('/', child: (_, args) => WithdrawPage()),
  ];

  static Inject get to => Inject<WithdrawModule>.of();
}

import 'package:cofrinho_piggy_bank/app/modules/deposit/deposit_controller.dart';
import 'package:cofrinho_piggy_bank/app/modules/deposit/deposit_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DepositModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => DepositController()),
      ];

  @override
  List<Router> get routers => [
    Router('/', child: (_, args) => DepositPage()),
  ];

  static Inject get to => Inject<DepositModule>.of();
}

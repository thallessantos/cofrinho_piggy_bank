import 'package:cofrinho_piggy_bank/app/modules/settings/settings_controller.dart';
import 'package:cofrinho_piggy_bank/app/modules/settings/settings_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SettingsModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => SettingsController()),
  ];

  @override
  List<Router> get routers => [
    Router('/', child: (_, args) => SettingsPage()),
  ];

  static Inject get to => Inject<SettingsModule>.of();
}

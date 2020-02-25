import 'package:cofrinho_piggy_bank/app/components/neumorphic_button.dart';
import 'package:cofrinho_piggy_bank/app/components/neumorphic_display.dart';
import 'package:cofrinho_piggy_bank/app/modules/settings/settings_controller.dart';
import 'package:cofrinho_piggy_bank/app/shared/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SettingsPage extends StatefulWidget {
  final String title;
  const SettingsPage({Key key, this.title = "Settings"}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends ModularState<SettingsPage, SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  NeumorphicButton(
                    width: 50,
                    icon: Icons.arrow_back_ios,
                    onPressed: () => Modular.to.pop(),
                  ),
                  Text("Configurações", style: TextStyle(fontSize: 20, color: Colors.black87)),
                  SizedBox(width: 50),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Moeda Padrão", style: TextStyle(fontSize: 16, color: Colors.black87)),
              ),
              Observer(builder: (_) {
                return _buildCurrencyOptions();
              }),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyOptions() {
    List<Widget> options = [];
    controller.currencyList.forEach((c) {
      if (c == controller.selectedCurrency) {
        options.add(NeumorphicDisplay(
          height: 50,
          width: 100,
          padding: EdgeInsets.zero,
          child: Center(child: Text(AppUtils.getCurrencySymbol(c), style: TextStyle(fontSize: 24))),
        ));
      } else {
        options.add(NeumorphicButton(
          width: 100,
          text: AppUtils.getCurrencySymbol(c),
          onPressed: () => controller.changeCurrency(c),
        ));
      }
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: options,
    );
  }
}

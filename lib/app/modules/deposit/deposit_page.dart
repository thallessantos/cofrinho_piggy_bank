import 'package:cofrinho_piggy_bank/app/app_controller.dart';
import 'package:cofrinho_piggy_bank/app/components/neumorphic_button.dart';
import 'package:cofrinho_piggy_bank/app/components/neumorphic_coin_button.dart';
import 'package:cofrinho_piggy_bank/app/components/neumorphic_display.dart';
import 'package:cofrinho_piggy_bank/app/modules/deposit/deposit_controller.dart';
import 'package:cofrinho_piggy_bank/app/shared/app_utils.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DepositPage extends StatefulWidget {
  final String title;
  const DepositPage({Key key, this.title = "Deposit"}) : super(key: key);

  @override
  _DepositPageState createState() => _DepositPageState();
}

class _DepositPageState extends ModularState<DepositPage, DepositController> {
  final AppController _appController = Modular.get();
  Coin coinMultiply;
  bool canShowMultipliers = false;

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
                    icon: Icons.arrow_back_ios,
                    onPressed: () => Modular.to.pop(),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add_box, size: 30, color: Colors.green),
                      SizedBox(width: 10),
                      Text("Depositar", style: TextStyle(fontSize: 20, color: Colors.green)),
                    ],
                  ),
                  NeumorphicButton(icon: Icons.help_outline),
                ],
              ),
              _amountDisplay(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Observer(builder: (_) {
                  return Column(
                    children: _coinButtons(),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _amountDisplay() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Hero(
        tag: "display",
        child: Material(
          color: Colors.transparent,
          child: NeumorphicDisplay(
            child: FittedBox(
              alignment: Alignment.centerRight,
              child: Observer(builder: (_) {
                return Text(
                  AppUtils.doubleToCurrency(_appController.amount, currency: _appController.currency),
                  style: TextStyle(fontSize: 50, wordSpacing: 10),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _coinButtons() {
    List<Widget> rows = [];
    List<Coin> coins = _appController.coins;

    Widget _buildMultiplierButton(Coin c, int quantity) {
      return NeumorphicButton(
        text: quantity.toString(),
        color: Colors.green,
        width: 50,
        onPressed: () => controller.increaseAmount(c, quantity: quantity),
      );
    }

    Widget _buildMultipliersContainer(Coin c) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: c == coinMultiply ? 300 : 0,
        onEnd: () { setState(() { canShowMultipliers = true; }); },
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 100),
          opacity: canShowMultipliers ? 1 : 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: canShowMultipliers ? <Widget>[
              Text('x', style: TextStyle(fontSize: 20)),
              _buildMultiplierButton(c, 5),
              _buildMultiplierButton(c, 10),
              _buildMultiplierButton(c, 50),
              _buildMultiplierButton(c, 100),
            ] : [],
          ),
        ),
      );
    }

    coins.forEach((c) => rows.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          NeumorphicCoinButton(
            imageName: c.imageName,
            size: c.imageSize,
            onPressed: () => controller.increaseAmount(c),
            onLongPressed: () {
              setState(() {
                canShowMultipliers = false;
                coinMultiply = c;
              });
            },
          ),
          _buildMultipliersContainer(c),
        ],
      ),
    ));

    return rows;
  }
}

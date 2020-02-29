import 'package:cofrinho_piggy_bank/app/app_controller.dart';
import 'package:cofrinho_piggy_bank/app/components/neumorphic_button.dart';
import 'package:cofrinho_piggy_bank/app/components/neumorphic_display.dart';
import 'package:cofrinho_piggy_bank/app/modules/home/home_controller.dart';
import 'package:cofrinho_piggy_bank/app/shared/app_utils.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final AppController _appController = Modular.get();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      drawer: _drawerMenu(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                NeumorphicButton(icon: Icons.menu, onPressed: () => _scaffoldKey.currentState.openDrawer()),
                NeumorphicButton(icon: Icons.settings, onPressed: () => Modular.to.pushNamed('/settings')),
              ],
            ),
            _amountDisplay(),
            _coinsDisplays(),
            Spacer(),
            _actionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _drawerMenu() {
    return Drawer(
      child: Container(
        color: Colors.grey[200],
        child: ListView(
          children: <Widget>[
            NeumorphicButton(icon: Icons.history, text: "Histórico", color: Colors.blueAccent, onPressed: () => Modular.to.pushNamed("/history"),),
            NeumorphicButton(icon: Icons.gavel, text: "Quebrar Cofrinho", color: Colors.red),
            NeumorphicButton(icon: Icons.stars, text: "Avaliar o app", color: Colors.amber),
            NeumorphicButton(icon: Icons.info, text: "Sobre"),
          ],
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

  Widget _coinsDisplays() {
    Widget _coinDisplay({double height, Coin coin}) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: NeumorphicDisplay(
          padding: EdgeInsets.zero,
          height: height,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("${coin.count ?? 0} x ", style: TextStyle(fontSize: 20)),
              Image.asset("assets/images/${coin.imageName}", width: coin.imageSize),
            ],
          ),
        ),
      );
    }

    return Observer(
      builder: (BuildContext context) {
        if (_appController.coins == null || _appController.coins.isEmpty)
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)),
            ),
          );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: _coinDisplay(height: 70, coin: _appController.coins[0])),
                  Expanded(child: _coinDisplay(height: 70, coin: _appController.coins[1])),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(child: _coinDisplay(height: 80, coin: _appController.coins[2])),
                  Expanded(child: _coinDisplay(height: 80, coin: _appController.coins[3])),
                ],
              ),
              _coinDisplay(height: 90, coin: _appController.coins[4]),
            ],
          ),
        );
      },
    );
  }

   Widget _actionButtons() {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 10),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget>[
           NeumorphicButton(
             icon: Icons.indeterminate_check_box,
             text: "Retirar",
             width: 150,
             color: Colors.redAccent,
             onPressed: () => Modular.to.pushNamed('/withdraw'),
           ),
           NeumorphicButton(
             icon: Icons.add_box,
             text: "Depositar",
             width: 150,
             color: Colors.green,
             onPressed: () => Modular.to.pushNamed('/deposit'),
           ),
         ],
       ),
     );
   }
}

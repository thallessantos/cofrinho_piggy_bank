import 'package:cofrinho_piggy_bank/app/components/neumorphic_button.dart';
import 'package:cofrinho_piggy_bank/app/modules/history/history_controller.dart';
import 'package:cofrinho_piggy_bank/app/shared/app_utils.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/movement.dart';
import 'package:cofrinho_piggy_bank/app/shared/models/movement_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  final String title;
  const HistoryPage({Key key, this.title = "History"}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends ModularState<HistoryPage, HistoryController> {
  final GlobalKey _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                NeumorphicButton(
                  width: 50,
                  icon: Icons.arrow_back_ios,
                  onPressed: () => Modular.to.pop(),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.history, size: 30, color: Colors.blueAccent),
                    SizedBox(width: 10),
                    Text("Histórico", style: TextStyle(fontSize: 20, color: Colors.blueAccent)),
                  ],
                ),
                SizedBox(width: 70),
              ],
            ),
            Expanded(
              child: Observer(builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: _buildListView(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    String date;

    return ListView.builder(
      key: _listKey,
      itemBuilder: (context, index) {
        if (index < controller.movements.length) {
          final Movement movement = controller.movements[index];
          if (date != DateFormat("EEEE, dd/MM/yyyy").format(movement.dateTime)) {
            date = DateFormat("EEEE, dd/MM/yyyy").format(movement.dateTime);
            return Column(
              children: <Widget>[
                _buildDateItem(date),
                _buildMovementItem(movement),
              ],
            );
          }
          return _buildMovementItem(movement);
        }
        else if (index > 1 && !controller.listFinished) {
          controller.getNextMovements();
          return Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.grey)),
          );
        } else if (controller.listFinished) {
          return Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: Text(
              "FIM",
              style: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return Container();
      },
      itemCount: controller.movements.length + 1,
    );
  }

  Widget _buildDateItem(String date) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[400]),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              date,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovementItem(Movement movement) {
    Color color = movement.type == MovementType.DEPOSIT ? Colors.green : Colors.redAccent;
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              "${movement.dateTime.hour}:${movement.dateTime.minute}",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
          Expanded(
            child: Text(
              "${movement.quantity ?? 0} x ",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16, color: color),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset("assets/images/${movement.coin.imageName}", width: 40, height: 40),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "${AppUtils.doubleToCurrency(movement.coin.value * movement.quantity)}",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16, color: color),
            ),
          ),
        ],
      ),
    );
  }
}
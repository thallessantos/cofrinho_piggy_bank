import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:cofrinho_piggy_bank/app/modules/deposit/deposit_controller.dart';
import 'package:cofrinho_piggy_bank/app/modules/deposit/deposit_module.dart';

void main() {
  initModule(DepositModule());
  DepositController deposit;

  setUp(() {
    deposit = DepositModule.to.get<DepositController>();
  });

  group('DepositController Test', () {
    test("First Test", () {
      expect(deposit, isInstanceOf<DepositController>());
    });

    test("Set Value", () {
      expect(deposit.amount, equals(0));
      // deposit.increment();
      expect(deposit.amount, equals(1));
    });
  });
}

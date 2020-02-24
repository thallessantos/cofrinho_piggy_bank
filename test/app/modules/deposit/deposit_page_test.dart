import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:cofrinho_piggy_bank/app/modules/deposit/deposit_page.dart';

main() {
  testWidgets('DepositPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(DepositPage(title: 'Deposit')));
    final titleFinder = find.text('Deposit');
    expect(titleFinder, findsOneWidget);
  });
}

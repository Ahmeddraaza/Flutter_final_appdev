import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_final_q2/main.dart';

void main() {
  testWidgets('Golden Test for WeeklyExpenseScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: WeeklyExpenseScreen(),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(WeeklyExpenseScreen),
      matchesGoldenFile('goldens/ui_sc.png'),
    );
  });
}

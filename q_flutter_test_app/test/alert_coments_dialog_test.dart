

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:q_flutter_test_app/common/alert_coments_dialog.dart';

main() {
  bool pressed = false;
  testWidgets('MyWidget not empty', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: AlertCommentsDialog(
        alertColumn: Column(),
      )),  
    );
    final button = find.byType(TextButton);
    
    expect(button, findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
    expect(find.byType(Divider), findsNothing);
    expect(find.byType(Column),findsWidgets);
    expect(find.byKey(Key("alert coments dialog")), findsOneWidget);
   await tester.tap(button);
    pressed = true;
    expect(pressed, true);
  });
}
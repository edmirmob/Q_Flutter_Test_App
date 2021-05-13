import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';



void main() {
  
  setUpAll((){
 
  });
  
 testWidgets(
    'Test description',
    (WidgetTester tester) async {
      // Write your test here

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(),
            body: CustomScrollView(
              key: Key('CustomScrolView key'),
              slivers: [
              
              ],
            ),
          ),
        ),
      );
      
      expect(find.byKey(Key("CustomScrolView key")), findsOneWidget);
      expect(find.byType(Container), findsNothing);
     
    },
  );
}

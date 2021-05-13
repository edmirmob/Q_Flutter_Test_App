import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:q_flutter_test_app/ui/home/widgets/table_comments.dart';


bool check = false;
void main() {
  setUp(() {});

  testWidgets('Table Comments not empty', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
          home: TableComments(
        check: true,
        postId: '5',
      )),
    );

    expect(check = true, true);
  
    final table = find.byType(Table);

    expect(table, findsOneWidget);
    expect(find.text('Body'), findsNothing);
    expect(find.byType(Divider), findsNothing);
    expect(find.byType(Column), findsNothing);
    expect(find.byKey(Key("padding Table_Comments key")), findsOneWidget);
    expect(find.byKey(Key("text postId Table_Comments key")), findsOneWidget);
    expect(find.byKey(Key("textSpan name Table_Comments key")), findsOneWidget);
  });

  // group('HappyTestingApp', () {
  //   group('constructor', () {
  //     test('throws AssertionError if repository is null', () {
  //       Home();
  //     });
  //   });
  // });
}

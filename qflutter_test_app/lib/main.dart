import 'package:flutter/material.dart';
import 'package:qflutter_test_app/locator.dart';
import 'package:qflutter_test_app/ui/screens/home.dart';

void main() {
  setUpLocator();
  runApp(QFLutterTestApp());
}

class QFLutterTestApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

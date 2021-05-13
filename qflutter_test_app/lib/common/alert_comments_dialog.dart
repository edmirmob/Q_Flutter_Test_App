import 'package:flutter/material.dart';

class AlertCommentsDialog extends StatelessWidget {
  final Widget alertRow;
  final Widget alertColumn;

  AlertCommentsDialog({Key key, this.alertColumn, this.alertRow})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: Key("alert coments dialog"),
      title: alertRow,
      content: alertColumn,
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.of(context).pop(), child: Text('OK')),
      ],
    );
  }
}
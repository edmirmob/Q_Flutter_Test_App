import 'package:flutter/material.dart';

class TableComments extends StatelessWidget {
  final bool check;
  final String postId, id, name, email, body;

  const TableComments({
    Key key,
    this.check,
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: {
        0: FlexColumnWidth(10),
        1: FlexColumnWidth(20),
        2: FlexColumnWidth(20),
        3: FlexColumnWidth(20),
      },
      border: TableBorder.all(width: 1, color: Colors.black45),
      children: [
        TableRow(children: [
          Padding(
              key: Key('padding Table_Comments key'),
              padding: const EdgeInsets.all(8.0),
              child: check
                  ? Text(
                      'PostId: \n $postId \n Id: $id',
                      textAlign: TextAlign.center,
                      key: Key('text postId Table_Comments key'),
                    )
                  : null),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: check
                  ? Text.rich(
                      TextSpan(
                          text: 'Name: \n$name',
                          children: [TextSpan(text: '...')]),
                      maxLines: 5,
                      key: Key('textSpan name Table_Comments key'),
                    )
                  : null),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: check ? Text('Email: \n$email') : null),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: check
                  ? Text.rich(
                      TextSpan(
                          text: 'Body: \n$body',
                          children: [TextSpan(text: '...')]),
                      maxLines: 5,
                    )
                  : null)
        ])
      ],
    );
  }
}

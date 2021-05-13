import 'package:flutter/material.dart';
import 'package:qflutter_test_app/common/alert_comments_dialog.dart';
import 'package:qflutter_test_app/locator.dart';
import 'package:qflutter_test_app/ui/widgets/comments_controller.dart';
import 'package:qflutter_test_app/ui/widgets/comments_data.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _commentsController = locator.get<CommentsController>();

  @override
  void initState() {
    super.initState();
    _commentsController.loadUpcominComments();
  }

  _alertRows(String email, String body, {String name}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Flexible(child: Text('${name.toString()}')),
        Text(
          'Email:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Flexible(child: Text('${email.toString()}')),
        Text(
          'Body:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Flexible(child: Text('${body.toString()}'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Q Flutter Testing App'),
        ),
        body: NotificationListener<ScrollNotification>(
            onNotification: (sn) {
              if (sn.metrics.pixels + 300 >= sn.metrics.maxScrollExtent) {
                _commentsController.loadMoreUpcomingClasses();
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: _commentsController.refreshComments,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(),
                    StreamBuilder<CommentsData>(
                        stream: _commentsController.commentsData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return SliverFillRemaining(
                                child:
                                Center(child: CircularProgressIndicator()));

                          return SliverGrid(
                            delegate:
                            SliverChildBuilderDelegate((context, index) {
                              // aa.add(snapshot.data!.comments);
                              return snapshot.data.comments.length > 0
                                  ? InkWell(
                                onTap: () => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertCommentsDialog(
                                        alertRow: Text(
                                            'PostId: ${snapshot.data?.comments[index].postId} - Id: ${snapshot.data?.comments[index].id}'),
                                        alertColumn: _alertRows(
                                          snapshot.data?.comments[index]
                                              .email,
                                          snapshot
                                              .data?.comments[index].body,
                                          name: snapshot
                                              .data?.comments[index].name,
                                        ),
                                      );

                                    }),
                                child: Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(10),
                                    1: FlexColumnWidth(20),
                                    2: FlexColumnWidth(20),
                                    3: FlexColumnWidth(20),
                                  },
                                  border: TableBorder.all(
                                      width: 1, color: Colors.black45),
                                  children: [
                                    TableRow(children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Text(
                                          'PostId: \n ${snapshot.data?.comments[index].postId} \n Id: ${snapshot.data?.comments[index].id}',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Text.rich(
                                          TextSpan(
                                              text:
                                              'Name: \n${snapshot.data?.comments[index].name}',
                                              children: [
                                                TextSpan(text: '...')
                                              ]),
                                          maxLines: 5,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Email: \n${snapshot.data?.comments[index].email}'),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Text.rich(
                                          TextSpan(
                                              text:
                                              'Body: \n${snapshot.data?.comments[index].body}',
                                              children: [
                                                TextSpan(text: '...')
                                              ]),
                                          maxLines: 5,
                                        ),
                                      )
                                    ])
                                  ],
                                ),
                              )


                                  : Container();
                            }, childCount: snapshot.data.comments.length),
                            gridDelegate:
                            SliverGridDelegateWithMaxCrossAxisExtent(
                              // mainAxisSpacing: 0.5,
                              childAspectRatio: 4,
                              maxCrossAxisExtent:
                              MediaQuery.of(context).size.width,
                            ),
                          );
                        }),
                    StreamBuilder<CommentsData>(
                      stream: _commentsController.commentsData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.active)
                          return const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        return SliverToBoxAdapter(
                          child: Container(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )));
  }
}
import 'package:flutter/material.dart';

import '../../common/alert_coments_dialog.dart';
import '../../core/repositories/comments_controller.dart';
import '../../core/repositories/comments_data.dart';
import '../../locator.dart';
import 'widgets/table_comments.dart';

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

  alertRows(String email, String body, {String name}) {
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

  double orientationScreen() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return 2.5;
    } else {
      return 3.5;
    }
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
              key: Key('CustomScrolView key'),
              slivers: [
                SliverToBoxAdapter(),
                StreamBuilder<CommentsData>(
                    stream: _commentsController.commentsData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return SliverFillRemaining(
                            child: Center(child: CircularProgressIndicator()));

                      return SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          // aa.add(snapshot.data!.comments);
                          return snapshot.data.comments.length > 0
                              ? InkWell(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertCommentsDialog(
                                          alertRow: Text(
                                              'PostId: ${snapshot.data?.comments[index].postId} - Id: ${snapshot.data?.comments[index].id}'),
                                          alertColumn: alertRows(
                                            snapshot
                                                .data?.comments[index].email,
                                            snapshot.data?.comments[index].body,
                                            name: snapshot
                                                .data?.comments[index].name,
                                          ),
                                        );
                                      }),
                                  child: TableComments(
                                    check:
                                        snapshot.data?.comments[index] != null,
                                    postId:
                                        '${snapshot.data?.comments[index].postId}',
                                    id: '${snapshot.data?.comments[index].id}',
                                    name:
                                        '${snapshot.data?.comments[index].name}',
                                    email:
                                        '${snapshot.data?.comments[index].email}',
                                    body:
                                        '${snapshot.data?.comments[index].body}',
                                  ))
                              : Container(
                                  key: Key('empty container home key'),
                                );
                        }, childCount: snapshot.data.comments.length),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          childAspectRatio: orientationScreen(),
                          maxCrossAxisExtent: MediaQuery.of(context).size.width,
                        ),
                      );
                    }),
                StreamBuilder<CommentsData>(
                  key: Key('streamBuilder home key'),
                  stream: _commentsController.commentsData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active)
                      return const SliverToBoxAdapter(
                        child: Padding(
                          key: Key('padding home key'),
                          padding: EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: Center(
                            key: Key('center home key'),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    return SliverToBoxAdapter(
                      key: Key('sliverToBoxAdapter home key'),
                      child: Container(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

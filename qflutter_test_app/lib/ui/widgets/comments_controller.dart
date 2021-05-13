

import 'package:qflutter_test_app/core/models/comments.dart';
import 'package:qflutter_test_app/core/providers/db_provider.dart';
import 'package:qflutter_test_app/core/repositories/comments_repository.dart';
import 'package:qflutter_test_app/locator.dart';
import 'package:qflutter_test_app/ui/widgets/comments_data.dart';
import 'package:rxdart/rxdart.dart';

class CommentsController {
  final _commentsDbProvider = locator.get<CommentsController>();
 // final _commentsRepository = locator.get<CommentsRepository>();
  final _commentsController =
  BehaviorSubject<CommentsData>.seeded(InitialCommentsData());
  var _perPage = 15;

  Future<List<Comments>> loadUpcominComments() async {
    final state = InitialCommentsData();
    _commentsController.add(LoadingCommentsData(comments: state.comments));
    final result = await _getComments();
    _commentsController.add(
        LoadingCommentsData(comments: [...result].sublist(0, 0 + _perPage)));

    return [...result];
  }

  Future<List<Comments>> _getComments() async {
    return await _commentsDbProvider._getComments();
  }

  Stream<CommentsData> get commentsData {
    return _commentsController.stream;
  }

  Future<void> loadMoreUpcomingClasses() async {
    final state = _commentsController.value;
    await Future.delayed(Duration(seconds: 2));

    final result = await _getComments();
    _commentsController.add(CommentsData(
      comments: [
        ...state.comments,
        ...result.getRange(
            state.comments.length, state.comments.length + _perPage)
      ],
    ));
  }

  Future<List<Comments>> refreshComments() async {
    final result = await _getComments();
    _commentsController.add(
        LoadingCommentsData(comments: [...result].sublist(0, 0 + _perPage)));

    return [...result];
  }
}

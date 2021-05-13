import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';

import '../models/comments.dart';
import '../providers/db_provider.dart';
import '../providers/comments_repository.dart';
import '../../locator.dart';
import '../../ui/widgets/../../core/repositories/comments_data.dart';

class CommentsController {
  final _commentsDbProvider = locator.get<DbProvider>();
  final _commentsControl = locator.get<CommentsRepository>();
  final _commentsController =
      BehaviorSubject<CommentsData>.seeded(InitialCommentsData());
  final _perPage = 15;

  Future<List<Comments>> loadUpcominComments() async {
    final state = InitialCommentsData();
    _commentsController.add(LoadingCommentsData(comments: state.comments));
    final result = await _getComments();
    _commentsController.add(
        LoadingCommentsData(comments: [...result].sublist(0, 0 + _perPage)));

    return [...result];
  }

  Future<List<Comments>> _getComments() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      _commentsControl.getAllComments();
    }
    return _commentsDbProvider.getAllComments();
  }

  Stream<CommentsData> get commentsData {
    return _commentsController.stream;
  }

  Future<void> loadMoreUpcomingClasses() async {
    final state = _commentsController.value;
    await Future.delayed(Duration(seconds: 2));

    final result = await _getComments();
    if ([...state.comments].length <= result.length)
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

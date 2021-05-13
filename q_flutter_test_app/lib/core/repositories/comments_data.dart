import '../models/comments.dart';

class CommentsData {
  final List<Comments> comments;

  CommentsData({
    this.comments,
  });
}

class InitialCommentsData extends CommentsData {
  InitialCommentsData()
      : super(
          comments: [],
        );
}
class LoadingCommentsData extends CommentsData{
  LoadingCommentsData({
    List<Comments>comments,

  }):super(comments: comments);
}

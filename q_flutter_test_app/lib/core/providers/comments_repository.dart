import 'package:dio/dio.dart';

import '../../common/http.dart';
import '../models/comments.dart';
import 'db_provider.dart';

class CommentsRepository with Http {
  Future<List<Comments>> getAllComments() async {
    final url = "https://jsonplaceholder.typicode.com/comments";
    Response response = await Dio().get(url);

    return (response.data as List).map((comments) {
      DbProvider().createComments(Comments.fromMap(comments));
    }).toList();
  }
}



import 'package:dio/dio.dart';
import 'package:qflutter_test_app/common/http.dart';
import 'package:qflutter_test_app/core/models/comments.dart';
import 'package:qflutter_test_app/core/providers/db_provider.dart';

class CommentsRepository with Http {

  Future<List<Comments>> getComments() async {
    var url = Uri.https(
      'jsonplaceholder.typicode.com', '/comments', );
    final response = await get(url);

    var items = <Comments>[];
    response.forEach((entity) {
      items.add(Comments.fromMap(entity));
    });

    return items;
  }

  Future<List<Comments>> getAllComments() async {
    final url = "https://jsonplaceholder.typicode.com/comments";
    var response = await Dio().get(url);

    return (response.data as List).map((comments) {
      print('Inserting $comments');
      DbProvider.db.createComments(Comments.fromMap(comments));
    }).toList();
  }

}

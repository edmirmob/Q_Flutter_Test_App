import 'dart:convert';

import 'package:http/http.dart' as http;


mixin Http {
  Future<T> get<T>(Uri url) {
    // final _commentsDbProvider = locator.get<DBProvider>();
    return http.get(url).then((response) {
      if (response.statusCode != 200) {
        throw HtttpException('${response.statusCode}');
        // _commentsDbProvider.getAllComments();
      }
      return jsonDecode(response.body) as T;
    });
  }
}

class HtttpException implements Exception {
  HtttpException(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}
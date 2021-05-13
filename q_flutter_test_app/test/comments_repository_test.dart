import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';




void main() {

  group('Comments Repository', () {
    
    test('testing connection', () async {
      final url = 'https://jsonplaceholder.typicode.com/comments';
      final res = await Dio().get(url);
      
         expect( res.statusCode==200, true);
         expect( res.statusCode==400, false);
         expect( res.data, isNotEmpty);

    });
  });



}
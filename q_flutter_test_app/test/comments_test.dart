import 'package:flutter_test/flutter_test.dart';
import 'package:q_flutter_test_app/core/models/comments.dart';

void main() {
  group('fromMap', () {
    test('Comments with all properties', () {
      final com = Comments.fromMap({
        'postId': 1,
        'id': 500,
        'name': 'name',
        'email': 'email',
        'body': 'body'
      });

      expect(
          com,
          Comments(
              postId: 1, id: 500, name: 'name', email: 'email', body: 'body'));
    });
    test('Comments with one property', () {
      final com = Comments.fromMap({
        'postId': 1,
        'id': 200,
      });

      expect(com.id, 200);
    });
  });

  group('toMap', () {
    test('check toMap', () {
      final com = Comments(
          postId: 1, id: 100, name: 'test', email: 'email', body: 'body');
      expect(com.toMap(), {
        'postId': 1,
        'id': 100,
        'name': 'test',
        'email': 'email',
        'body': 'body'
      });
    });
  });
}

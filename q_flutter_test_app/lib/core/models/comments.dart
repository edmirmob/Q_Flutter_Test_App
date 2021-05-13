import 'package:flutter/material.dart';

class Comments {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comments({
    @required this.postId,
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.body,
  });

  static Comments fromMap(Map<String, Object> data) {
    return Comments(
      postId: data['postId'],
      id: data['id'],
      name: data['name'],
      email: data['email'],
      body: data['body'],
    );
  }

 Map<String, dynamic> toMap() => {
        'postId': postId,
        "id": id,
        'name': name,
        "email": email,
        "body": body,
      };

  @override
  int get hashCode => hashValues(postId, id, name, email, body);

  @override
  bool operator ==(other) {
    if (identical(this, other)) {
      return true;
    }
    if (runtimeType != other.runtimeType) return false;
    final Comments otherComments = other;
    return postId == otherComments.postId &&
        id == otherComments.id &&
        name == otherComments.name &&
        email == otherComments.email &&
        body == otherComments.body;
  }
}

import 'package:flutter_partiel_5al/model/user.dart';

class Comment {
  int? id;
  int? createdAt;
  String? content;
  User? user;

  Comment({
    this.id,
    this.createdAt,
    this.content,
    this.user,
  });

  static Comment fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      createdAt: json['created_at'],
      content: json['content'],
      user: User.fromJson(json['user']),
    );
  }
}

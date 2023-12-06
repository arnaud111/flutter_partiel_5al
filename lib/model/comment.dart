import 'package:flutter_partiel_5al/model/user.dart';

class Comment {
  int? id;
  int? createdAt;
  String? content;
  User? author;

  Comment({
    this.id,
    this.createdAt,
    this.content,
    this.author,
  });

  static Comment fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      createdAt: json['created_at'],
      content: json['content'],
      author: User.fromJson(json['author']),
    );
  }
}

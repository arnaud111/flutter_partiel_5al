import 'package:flutter_partiel_5al/model/comment.dart';
import 'package:flutter_partiel_5al/model/user.dart';

import 'image.dart';

class Post {
  int? id;
  int? createdAt;
  String? content;
  Image? image;
  User? author;
  List<Comment>? comments;
  int? commentsCount;

  Post({
    this.id,
    this.createdAt,
    this.content,
    this.image,
    this.author,
    this.comments,
    this.commentsCount,
  });

  static Post fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      createdAt: json['created_at'],
      content: json['content'],
      image: Image.fromJson(json['image']),
      author: User.fromJson(json['author']),
      comments: json.containsKey('comments') ? (json['comments'] as List<dynamic>).map((comment) => Comment.fromJson(comment)).toList() : null,
      commentsCount: json.containsKey("comments_count") ? json['comments_count'] : null,
    );
  }
}

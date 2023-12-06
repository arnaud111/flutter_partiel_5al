import 'package:flutter_partiel_5al/datasource/abstract/comment_datasource.dart';

class CommentRepository {
  final CommentDataSource commentDataSource;

  CommentRepository({required this.commentDataSource});

  Future<void> delete(int commentId) async {
    return commentDataSource.delete(commentId);
  }

  Future<void> patch(int commentId, String content) async {
    return commentDataSource.patch(commentId, content);
  }

  Future<void> post(int postId, String content) async {
    return commentDataSource.post(postId, content);
  }

}
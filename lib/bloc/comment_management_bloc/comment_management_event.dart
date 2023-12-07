part of 'comment_management_bloc.dart';

@immutable
abstract class CommentManagementEvent {}

class InitCommentManagement extends CommentManagementEvent {}

class CreateComment extends CommentManagementEvent {
  final int postId;
  final String content;

  CreateComment({
    required this.postId,
    required this.content,
  });
}

class DeleteComment extends CommentManagementEvent {
  final int commentId;

  DeleteComment({
    required this.commentId,
  });
}

class UpdateComment extends CommentManagementEvent {
  final int commentId;
  final String content;

  UpdateComment({
    required this.commentId,
    required this.content,
  });
}

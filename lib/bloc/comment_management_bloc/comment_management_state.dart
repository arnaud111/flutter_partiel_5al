part of 'comment_management_bloc.dart';

enum CommentStatusEnum {
  initial,
  loading,
  deleted,
  created,
  updated,
  error,
}

class CommentManagementState {
  CommentStatusEnum status;
  String? message;

  CommentManagementState({
    required this.status,
    this.message,
  });
}

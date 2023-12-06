part of 'post_management_bloc.dart';

enum PostStatusEnum {
  initial,
  loading,
  deleted,
  created,
  updated,
  error,
}

class PostManagementState {
  PostStatusEnum status;
  String? message;

  PostManagementState({
    required this.status,
    this.message,
  });
}

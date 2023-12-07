part of 'post_management_bloc.dart';

@immutable
abstract class PostManagementEvent {}

class InitPostManagement extends PostManagementEvent {}

class Create extends PostManagementEvent {

  final String content;
  final File? image;

  Create({
    required this.content,
    this.image,
  });
}

class Update extends PostManagementEvent {

  final int postId;
  final String? content;
  final File? image;

  Update({
    required this.postId,
    this.content,
    this.image,
  });
}

class Delete extends PostManagementEvent {

  final int postId;

  Delete({
    required this.postId,
  });
}

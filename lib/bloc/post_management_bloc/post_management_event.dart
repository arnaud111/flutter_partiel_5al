part of 'post_management_bloc.dart';

@immutable
abstract class PostManagementEvent {}

class Init extends PostManagementEvent {}

class CreatePostEvent extends PostManagementEvent {

  final String content;
  final File? image;

  CreatePostEvent({
    required this.content,
    this.image,
  });
}

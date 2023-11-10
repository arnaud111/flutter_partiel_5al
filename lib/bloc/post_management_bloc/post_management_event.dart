part of 'post_management_bloc.dart';

@immutable
abstract class PostManagementEvent {}

class Init extends PostManagementEvent {}

class CreatePostEvent extends PostManagementEvent {

  final String textMessage;
  final String? base64Image;

  CreatePostEvent({
    required this.textMessage,
    this.base64Image,
  });
}

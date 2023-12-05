part of 'post_list_user_bloc.dart';

@immutable
abstract class PostListUserEvent {}

class Init extends PostListUserEvent {}

class GetListPost extends PostListUserEvent {

  final int userId;

  GetListPost({
    required this.userId
  });
}

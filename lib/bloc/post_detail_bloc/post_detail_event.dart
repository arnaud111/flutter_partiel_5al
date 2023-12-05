part of 'post_detail_bloc.dart';

@immutable
abstract class PostDetailEvent {}

class Init extends PostDetailEvent {}

class Get extends PostDetailEvent {

  final int postId;

  Get({
    required this.postId,
  });
}

part of 'post_detail_bloc.dart';

class PostDetailState {

  StateStatus status;
  Post? post;

  PostDetailState({
    required this.status,
    this.post,
  });

  PostDetailState copyWith({StateStatus? status}) {
    return PostDetailState(
      status: status ?? this.status,
      post: post,
    );
  }
}

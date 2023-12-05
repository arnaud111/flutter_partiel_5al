part of 'post_list_user_bloc.dart';

class PostListUserState {

  StateStatus status;
  PostList? postList;

  PostListUserState({
    required this.status,
    this.postList,
  });

  PostListUserState copyWith({StateStatus? status}) {
    return PostListUserState(
      status: status ?? this.status,
      postList: postList,
    );
  }
}

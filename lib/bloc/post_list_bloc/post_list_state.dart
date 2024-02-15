part of 'post_list_bloc.dart';

class PostListState {
  PostList? postList;
  StateStatus status;

  PostListState({
    this.postList,
    required this.status,
  });

  PostListState copyWith({StateStatus? status}) {
    return PostListState(
      status: status ?? this.status,
      postList: postList,
    );
  }

  void addInList(PostList newList) {
    if (postList != null) {
      postList!.addInPostList(newList);
    }
  }
}

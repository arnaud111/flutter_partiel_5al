class PostDetailRouteArguments {
  int postId;
  Function? onDispose;

  PostDetailRouteArguments({
    required this.postId,
    this.onDispose,
  });
}

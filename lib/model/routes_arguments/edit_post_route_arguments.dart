import '../post.dart';

class EditPostRouteArguments {
  Post post;
  Function? onDispose;

  EditPostRouteArguments({
    required this.post,
    this.onDispose,
  });
}

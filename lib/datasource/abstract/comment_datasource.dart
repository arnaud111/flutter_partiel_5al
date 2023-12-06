
abstract class CommentDataSource {

  Future<void> delete(int commentId);

  Future<void> patch(int commentId, String content);

  Future<void> post(int postId, String content);
}

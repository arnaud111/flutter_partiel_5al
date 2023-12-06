
import '../../model/post_list.dart';
import '../../model/user.dart';

abstract class UserDataSource {

  Future<PostList> getPostByUserId(int userId, int? page, int? perPage);

  Future<User> getById(int? userId);

}

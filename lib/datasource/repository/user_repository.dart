import 'package:flutter_partiel_5al/datasource/abstract/user_datasource.dart';

import '../../model/post_list.dart';
import '../../model/user.dart';

class UserRepository {
  final UserDataSource userDataSource;

  UserRepository({required this.userDataSource});

  Future<PostList> getPostByUserId(int userId, int? page, int? perPage) async {
    return userDataSource.getPostByUserId(userId, page, perPage);
  }

  Future<User> getById(int? userId) async {
    return userDataSource.getById(userId);
  }

}
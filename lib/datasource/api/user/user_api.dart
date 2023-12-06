import 'package:flutter_partiel_5al/datasource/abstract/user_datasource.dart';
import 'package:flutter_partiel_5al/model/user.dart';

import '../../../model/post_list.dart';
import '../api.dart';
import '../http_error.dart';

class UserApi extends UserDataSource {

  @override
  Future<PostList> getPostByUserId(int userId, int? page, int? perPage) async {
    final response = await Api.dio.get("/user/$userId/posts", data: {
      "page": page,
      "per_page": perPage,
    });
    if (response.statusCode != 200) {
      throw HttpError.fromJson(response.data);
    }
    return PostList.fromJson(response.data);
  }

  @override
  Future<User> getById(int? userId) async {
    final response = await Api.dio.get("/user/$userId");
    if (response.statusCode != 200) {
      throw HttpError.fromJson(response.data);
    }
    return User.fromJson(response.data);
  }
}
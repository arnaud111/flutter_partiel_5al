import 'package:flutter_partiel_5al/api/api.dart';
import 'package:flutter_partiel_5al/model/user.dart';

import '../../model/post_list.dart';

class UserApi extends Api {

  static Future<PostList> getPostByUserId(int? userId, int? page, int? perPage) async {
    final response = await Api.dio.get("/user/$userId/post", data: {
      "page": page,
      "per_page": perPage,
    });
    return PostList.fromJson(response.data);
  }

  static Future<User> getById(int? userId) async {
    final response = await Api.dio.get("/user/$userId");
    return User.fromJson(response.data);
  }
}
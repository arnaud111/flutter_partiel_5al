import 'package:flutter_partiel_5al/api/api.dart';
import 'package:flutter_partiel_5al/model/user.dart';

import '../../model/post_list.dart';
import '../http_error.dart';

class UserApi extends Api {

  static Future<PostList> getPostByUserId(int userId, int? page, int? perPage) async {
    final response = await Api.dio.get("/user/$userId/posts", data: {
      "page": page,
      "per_page": perPage,
    });
    if (response.statusCode != 200) {
      throw HttpError.fromJson(response.data);
    }
    print(response.data);
    return PostList.fromJson(response.data);
  }

  static Future<User> getById(int? userId) async {
    final response = await Api.dio.get("/user/$userId");
    if (response.statusCode != 200) {
      throw HttpError.fromJson(response.data);
    }
    return User.fromJson(response.data);
  }
}
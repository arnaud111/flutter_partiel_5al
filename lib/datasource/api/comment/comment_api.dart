import 'package:flutter_partiel_5al/datasource/abstract/comment_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';
import '../http_error.dart';

class CommentApi extends CommentDataSource {

  @override
  Future<void> delete(int commentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Api.dio.options.headers["Authorization"] = "Bearer ${prefs.getString('auth_token')}";
    final response = await Api.dio.delete("/comment/$commentId");
    if (response.statusCode != 200) {
      throw HttpError.fromJson(response.data);
    }
  }

  @override
  Future<void> patch(int commentId, String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Api.dio.options.headers["Authorization"] = "Bearer ${prefs.getString('auth_token')}";
    final response = await Api.dio.patch("/comment/$commentId", data: {
      "content": content,
    });
    if (response.statusCode != 200) {
      throw HttpError.fromJson(response.data);
    }
  }

  @override
  Future<void> post(int postId, String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Api.dio.options.headers["Authorization"] = "Bearer ${prefs.getString('auth_token')}";
    final response = await Api.dio.post("/comment", data: {
      "post_id": postId,
      "content": content,
    });
    if (response.statusCode != 200) {
      throw HttpError.fromJson(response.data);
    }
  }
}
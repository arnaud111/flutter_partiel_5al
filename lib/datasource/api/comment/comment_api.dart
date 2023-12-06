import 'package:flutter_partiel_5al/datasource/abstract/comment_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class CommentApi extends CommentDataSource {

  @override
  Future<void> delete(int commentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Api.dio.options.headers["Authorization"] = "Bearer ${prefs.getString('auth_token')}";
    await Api.dio.delete("/comment/$commentId");
  }

  @override
  Future<void> patch(int commentId, String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Api.dio.options.headers["Authorization"] = "Bearer ${prefs.getString('auth_token')}";
    await Api.dio.patch("/comment/$commentId", data: {
      "content": content,
    });
  }

  @override
  Future<void> post(int postId, String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Api.dio.options.headers["Authorization"] = "Bearer ${prefs.getString('auth_token')}";
    await Api.dio.patch("/comment", data: {
      "post_id": postId,
      "content": content,
    });
  }
}
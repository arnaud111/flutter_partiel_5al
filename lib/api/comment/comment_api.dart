import 'package:flutter_partiel_5al/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentApi extends Api {

  static Future<void> delete(int commentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Api.dio.options.headers["Authorization"] = "Bearer ${prefs.getString('auth_token')}";
    await Api.dio.delete("/comment/$commentId");
  }

  static Future<void> patch(int commentId, String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Api.dio.options.headers["Authorization"] = "Bearer ${prefs.getString('auth_token')}";
    await Api.dio.patch("/comment/$commentId", data: {
      "content": content,
    });
  }

  static Future<void> post(int postId, String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Api.dio.options.headers["Authorization"] = "Bearer ${prefs.getString('auth_token')}";
    await Api.dio.patch("/comment", data: {
      "post_id": postId,
      "content": content,
    });
  }
}
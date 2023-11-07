import 'package:flutter_partiel_5al/api/api.dart';
import 'package:flutter_partiel_5al/model/post.dart';
import 'package:flutter_partiel_5al/model/post_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostApi extends Api {

  static Future<void> delete(int postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Api.dio.options.headers["Authorization"] = "Bearer ${prefs.getString('auth_token')}";
    await Api.dio.delete("/post/$postId");
  }

  static Future<Post> getById(int postId) async {
    final response = await Api.dio.get("/post/$postId");
    return Post.fromJson(response.data);
  }

  static Future<Post> patch(int postId, String? content, String? image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Api.dio.options.headers["Authorization"] = "Bearer ${prefs.getString('auth_token')}";
    final response = await Api.dio.patch("/post/$postId", data: {
      "content": content,
      "base_64_image": image,
    });
    return Post.fromJson(response.data);
  }

  static Future<PostList> get(int? page, int? perPage) async {
    final response = await Api.dio.get("/post", data: {
      "page": page,
      "per_page": perPage,
    });
    return PostList.fromJson(response.data);
  }

  static Future<void> post(String? content, String? image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Api.dio.options.headers["Authorization"] = "Bearer ${prefs.getString('auth_token')}";
    await Api.dio.post("/post", data: {
      "content": content,
      "base_64_image": image,
    });
  }
}
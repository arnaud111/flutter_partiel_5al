import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_partiel_5al/datasource/abstract/post_datasource.dart';
import 'package:flutter_partiel_5al/model/post.dart';
import 'package:flutter_partiel_5al/model/post_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';
import '../http_error.dart';

class PostApi extends PostDataSource {

  @override
  Future<void> delete(int postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Api.dio.options.headers["Authorization"] =
        "Bearer ${prefs.getString('auth_token')}";
    final response = await Api.dio.delete("/post/$postId");
    if (response.statusCode != 200) {
      throw HttpError.fromJson(response.data);
    }
  }

  @override
  Future<Post> getById(int postId) async {
    final response = await Api.dio.get("/post/$postId");
    if (response.statusCode != 200) {
      throw HttpError.fromJson(response.data);
    }
    return Post.fromJson(response.data);
  }

  @override
  Future<Post> patch(int postId, String? content, File? image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Api.dio.options.headers["Authorization"] =
        "Bearer ${prefs.getString('auth_token')}";
    final response = await Api.dio.patch("/post/$postId", data: {
      "content": content,
      "base_64_image": image != null ? await MultipartFile.fromFile(
        image.path,
      ) : null,
    });
    if (response.statusCode != 200) {
      throw HttpError.fromJson(response.data);
    }
    return Post.fromJson(response.data);
  }

  @override
  Future<PostList> get(int? page, int? perPage) async {
    final response = await Api.dio.get("/post", data: {
      "page": page,
      "per_page": perPage,
    });
    if (response.statusCode != 200) {
      throw HttpError.fromJson(response.data);
    }
    return PostList.fromJson(response.data);
  }

  @override
  Future<Post> post(String content, File? image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Api.dio.options.headers["Authorization"] =
        "Bearer ${prefs.getString('auth_token')}";
    final response = await Api.dio.post("/post",
        data: FormData.fromMap({
          "content": content,
          "base_64_image": image != null ? await MultipartFile.fromFile(
            image.path,
          ) : null,
        }));
    if (response.statusCode != 200) {
      throw HttpError.fromJson(response.data);
    }
    return Post.fromJson(response.data);
  }
}

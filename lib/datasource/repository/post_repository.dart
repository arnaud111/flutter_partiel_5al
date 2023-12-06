
import 'dart:io';

import 'package:flutter_partiel_5al/datasource/abstract/post_datasource.dart';

import '../../model/post.dart';
import '../../model/post_list.dart';

class PostRepository {
  final PostDataSource postDataSource;

  PostRepository({required this.postDataSource});

  Future<void> delete(int postId) async {
    return postDataSource.delete(postId);
  }

  Future<Post> getById(int postId) async {
    return postDataSource.getById(postId);
  }

  Future<Post> patch(int postId, String? content, String? image) async {
    return postDataSource.patch(postId, content, image);
  }

  Future<PostList> get(int? page, int? perPage) async {
    return postDataSource.get(page, perPage);
  }

  Future<Post> post(String content, File? image) async {
    return postDataSource.post(content, image);
  }

}
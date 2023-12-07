
import 'dart:io';

import '../../model/post.dart';
import '../../model/post_list.dart';

abstract class PostDataSource {

  Future<void> delete(int postId);

  Future<Post> getById(int postId);

  Future<Post> patch(int postId, String? content, File? image);

  Future<PostList> get(int? page, int? perPage);

  Future<Post> post(String content, File? image);

}

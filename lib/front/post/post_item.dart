import 'package:flutter/material.dart';
import 'package:flutter_partiel_5al/front/post/row_info_author.dart';
import 'package:flutter_partiel_5al/front/screen/post_detail_screen.dart';
import 'package:flutter_partiel_5al/model/routes_arguments/post_detail_route_arguments.dart';

import '../../model/post.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.post,
    this.clickable = true,
    this.refreshFunction,
  });

  final Post post;
  final bool clickable;
  final Function? refreshFunction;

  void onCLick(BuildContext context) {
    PostDetailScreen.navigateTo(
      context,
      PostDetailRouteArguments(
        postId: post.id!,
        onDispose: refreshFunction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onCLick(context),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Color(0xFF31363B),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowInfoAuthor(
                createdAt: post.createdAt!,
                author: post.author!,
                clickableProfile: clickable,
              ),
              Text(
                post.content ?? "",
              ),
              if (post.image != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 300,
                      ),
                      child: Image.network(
                        post.image!.url!,
                      ),
                    ),
                  ),
                ),
              Row(
                children: [
                  const Icon(
                    Icons.comment,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "${post.commentsCount}",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

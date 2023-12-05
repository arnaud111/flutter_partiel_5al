import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_list_user_bloc/post_list_user_bloc.dart';
import 'package:flutter_partiel_5al/widget/view/post_detail.dart';
import 'package:flutter_partiel_5al/widget/view/profile.dart';

import '../../bloc/post_detail_bloc/post_detail_bloc.dart';
import '../../model/post.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.post,
    this.clickable = true,
  });

  final Post post;
  final bool clickable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
              create: (BuildContext context) => PostDetailBloc(),
              child: PostDetail(postId: post.id!),
            ),
          ),
        );
      },
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
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (clickable == false) {
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => BlocProvider(
                            create: (BuildContext context) => PostListUserBloc(),
                            child: Profile(user: post.author!),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      post.author?.name ?? "",
                      style: const TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    getDate(),
                    style: const TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
              Text(
                post.content ?? "",
              ),
              if (post.image != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16
                  ),
                  child: Center(
                    child: Image.network(post.image!.url!),
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

  String getDate() {
    DateTime dataTime = DateTime.fromMillisecondsSinceEpoch(post.createdAt!);
    return "${dataTime.year}/${dataTime.month}/${dataTime.day} ${dataTime.hour}:${dataTime.minute}";
  }
}

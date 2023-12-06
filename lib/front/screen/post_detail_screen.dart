import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_detail_bloc/post_detail_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/front/post/comment_item.dart';
import 'package:flutter_partiel_5al/front/post/row_info_author.dart';
import 'package:flutter_partiel_5al/front/widget/loading.dart';

import '../../bloc/user_bloc/auth_bloc.dart';
import '../../model/post.dart';

class PostDetailScreen extends StatefulWidget {
  static const String routeName = "/postDetails";

  static void navigateTo(BuildContext context, int postId) {
    Navigator.of(context).pushNamed(routeName, arguments: postId);
  }

  const PostDetailScreen({
    super.key,
    required this.postId,
  });

  final int postId;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  void initState() {
    super.initState();
    final postListBloc = BlocProvider.of<PostDetailBloc>(context);
    postListBloc.add(Get(
      postId: widget.postId,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Post Detail"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<PostDetailBloc, PostDetailState>(
                builder: (context, statePost) {
              switch (statePost.status.status) {
                case StateStatusEnum.initial:
                  return Container();
                case StateStatusEnum.loading:
                  return const Loading();
                case StateStatusEnum.success:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RowInfoAuthor(
                        createdAt: statePost.post!.createdAt!,
                        author: statePost.post!.author!,
                      ),
                      Text(
                        statePost.post!.content!,
                      ),
                      if (statePost.post!.image != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 300,
                              ),
                              child: Image.network(statePost.post!.image!.url!),
                            ),
                          ),
                        ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, stateAuth) {
                          if (stateAuth.status.status ==
                                  StateStatusEnum.success &&
                              stateAuth.auth!.id ==
                                  statePost.post!.author!.id) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                      const Divider(
                        indent: 16,
                        endIndent: 16,
                        color: Colors.white70,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: statePost.post!.comments!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: CommentItem(
                                  comment: statePost.post!.comments![index]),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                case StateStatusEnum.error:
                  return Center(
                    child: Text(statePost.status.message!),
                  );
              }
            }),
          ),
        );
      },
    );
  }

  String getDate(Post post) {
    DateTime dataTime = DateTime.fromMillisecondsSinceEpoch(post.createdAt!);
    return "${dataTime.year}/${dataTime.month}/${dataTime.day} ${dataTime.hour}:${dataTime.minute}";
  }
}

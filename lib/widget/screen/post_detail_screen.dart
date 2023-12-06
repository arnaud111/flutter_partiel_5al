import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_detail_bloc/post_detail_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/widget/post/comment_item.dart';
import 'package:flutter_partiel_5al/widget/post/row_info_author.dart';

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
                builder: (context, state) {
              switch (state.status.status) {
                case StateStatusEnum.initial:
                  return Container();
                case StateStatusEnum.loading:
                  return const Center(
                    child: SizedBox(
                      width: 75,
                      height: 75,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                case StateStatusEnum.success:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RowInfoAuthor(
                        createdAt: state.post!.createdAt!,
                        author: state.post!.author!,
                      ),
                      Text(
                        state.post!.content!,
                      ),
                      if (state.post!.image != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 300,
                              ),
                              child: Image.network(state.post!.image!.url!),
                            ),
                          ),
                        ),
                      const Divider(
                        indent: 16,
                        endIndent: 16,
                        color: Colors.white70,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.post!.comments!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: CommentItem(
                                  comment: state.post!.comments![index]),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                case StateStatusEnum.error:
                  return Center(
                    child: Text(state.status.message!),
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

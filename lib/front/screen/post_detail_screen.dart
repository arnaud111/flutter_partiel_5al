import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_detail_bloc/post_detail_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_management_bloc/post_management_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/front/alert/confirm_delete_alert.dart';
import 'package:flutter_partiel_5al/front/post/comment_item.dart';
import 'package:flutter_partiel_5al/front/post/row_info_author.dart';
import 'package:flutter_partiel_5al/front/screen/edit_post_screen.dart';
import 'package:flutter_partiel_5al/front/widget/loading.dart';
import 'package:flutter_partiel_5al/front/widget/stack_loading.dart';

import '../../bloc/post_list_bloc/post_list_bloc.dart';
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
    getPost();
  }

  void getPost() {
    final postListBloc = BlocProvider.of<PostDetailBloc>(context);
    postListBloc.add(Get(
      postId: widget.postId,
    ));
  }

  void initPostManagement() {
    final postListBloc = BlocProvider.of<PostManagementBloc>(context);
    postListBloc.add(InitPostManagement());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostManagementBloc, PostManagementState>(
      builder: (context, postManagementState) {
        if (postManagementState.status == PostStatusEnum.deleted) {
          Future.delayed(Duration.zero, () {
            final postListBloc = BlocProvider.of<PostListBloc>(context);
            postListBloc.add(GetListPost());
            Navigator.of(context).pop();
          });
        } else if (postManagementState.status == PostStatusEnum.updated) {
          getPost();
          initPostManagement();
        }
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Post Detail"),
              ),
              body: StackLoading(
                loadingCondition: () {
                  return postManagementState.status == PostStatusEnum.loading;
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<PostDetailBloc, PostDetailState>(
                      builder: (context, postState) {
                    switch (postState.status.status) {
                      case StateStatusEnum.initial:
                        return Container();
                      case StateStatusEnum.loading:
                        return const Loading();
                      case StateStatusEnum.success:
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowInfoAuthor(
                              createdAt: postState.post!.createdAt!,
                              author: postState.post!.author!,
                            ),
                            Text(
                              postState.post!.content!,
                            ),
                            if (postState.post!.image != null)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxHeight: 300,
                                    ),
                                    child: Image.network(
                                        postState.post!.image!.url!),
                                  ),
                                ),
                              ),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, authState) {
                                if (authState.status.status ==
                                        StateStatusEnum.success &&
                                    authState.auth!.id ==
                                        postState.post!.author!.id) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () => edit(postState.post!),
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      GestureDetector(
                                        onTap: delete,
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
                                itemCount: postState.post!.comments!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: CommentItem(
                                        comment:
                                            postState.post!.comments![index]),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      case StateStatusEnum.error:
                        return Center(
                          child: Text(postState.status.message!),
                        );
                    }
                  }),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void edit(Post post) {
    EditPostScreen.navigateTo(context, post);
  }

  void delete() {
    showDialog(
      context: context,
      builder: (context) => const ConfirmDeleteAlert(),
    ).then((confirm) {
      if (confirm == true) {
        final postListBloc = BlocProvider.of<PostManagementBloc>(context);
        postListBloc.add(Delete(
          postId: widget.postId,
        ));
      }
    });
  }
}

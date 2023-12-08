import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/comment_management_bloc/comment_management_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_detail_bloc/post_detail_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_management_bloc/post_management_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/datasource/repository/comment_repository.dart';
import 'package:flutter_partiel_5al/front/alert/confirm_delete_alert.dart';
import 'package:flutter_partiel_5al/front/post/comment_item.dart';
import 'package:flutter_partiel_5al/front/post/row_info_author.dart';
import 'package:flutter_partiel_5al/front/screen/edit_post_screen.dart';
import 'package:flutter_partiel_5al/front/widget/loading.dart';
import 'package:flutter_partiel_5al/front/widget/stack_loading.dart';
import 'package:flutter_partiel_5al/model/routes_arguments/edit_post_route_arguments.dart';
import 'package:flutter_partiel_5al/model/routes_arguments/post_detail_route_arguments.dart';

import '../../bloc/user_bloc/auth_bloc.dart';
import '../../model/post.dart';
import '../alert/login_alert.dart';
import '../alert/send_comment_alert.dart';

class PostDetailScreen extends StatefulWidget {
  static const String routeName = "/postDetails";

  static void navigateTo(BuildContext context, PostDetailRouteArguments arguments) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  const PostDetailScreen({
    super.key,
    required this.postId,
    this.onDispose,
  });

  final int postId;
  final Function? onDispose;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  void initState() {
    super.initState();
    getPost();
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose!();
    }
    super.dispose();
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

  void displayLogin() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => const LoginAlert(),
    );
  }

  void addComment(int postId) {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => CommentManagementBloc(
          commentRepository: context.read<CommentRepository>(),
        ),
        child: SendCommentAlert(
          postId: postId,
        ),
      ),
    ).then((value) {
      if (value == true) {
        getPost();
      }
    });
  }

  void edit(Post post) {
    EditPostScreen.navigateTo(
      context,
      EditPostRouteArguments(
        post: post,
        onDispose: getPost,
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostManagementBloc, PostManagementState>(
      builder: (context, postManagementState) {
        if (postManagementState.status == PostStatusEnum.deleted) {
          Future.delayed(Duration.zero, () {
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
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
                            Row(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (authState.status.status ==
                                        StateStatusEnum.success) {
                                      addComment(widget.postId);
                                    } else {
                                      displayLogin();
                                    }
                                  },
                                  child: const Icon(
                                    Icons.add,
                                  ),
                                ),
                              ],
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
}

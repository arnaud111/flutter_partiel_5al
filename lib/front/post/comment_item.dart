import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/comment_management_bloc/comment_management_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/datasource/repository/comment_repository.dart';
import 'package:flutter_partiel_5al/front/alert/edit_comment_alert.dart';
import 'package:flutter_partiel_5al/front/post/row_info_author.dart';

import '../../bloc/user_bloc/auth_bloc.dart';
import '../../model/comment.dart';
import '../alert/confirm_delete_alert.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.comment,
    required this.reloadComment,
  });

  final Comment comment;
  final Function reloadComment;

  void edit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          EditCommentAlert(
            comment: comment,
            reloadComment: reloadComment,
          ),
    );
  }

  void delete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ConfirmDeleteAlert(),
    ).then((confirm) {
      if (confirm == true) {
        final bloc = BlocProvider.of<CommentManagementBloc>(context);
        bloc.add(DeleteComment(
          commentId: comment.id!,
        ));
      }
    });
  }

  String getDate() {
    DateTime dataTime = DateTime.fromMillisecondsSinceEpoch(comment.createdAt!);
    return "${dataTime.year}/${dataTime.month}/${dataTime.day} ${dataTime
        .hour}:${dataTime.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CommentManagementBloc(
            commentRepository: context.read<CommentRepository>(),
          ),
      child: BlocListener<CommentManagementBloc, CommentManagementState>(
        listener: (context, state) {
          if (state.status == CommentStatusEnum.deleted) {
            reloadComment();
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            return Container(
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
                      createdAt: comment.createdAt!,
                      author: comment.author!,
                    ),
                    Text(comment.content ?? ""),
                    if (authState.status.status == StateStatusEnum.success &&
                        authState.auth!.id == comment.author!.id)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => edit(context),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () => delete(context),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

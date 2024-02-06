import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/comment_management_bloc/comment_management_bloc.dart';

import '../../datasource/repository/comment_repository.dart';
import '../../model/comment.dart';
import '../widget/loading.dart';

class EditCommentAlert extends StatefulWidget {
  const EditCommentAlert({
    super.key,
    required this.comment,
    required this.reloadComment,
  });

  final Comment comment;
  final Function reloadComment;

  @override
  State<EditCommentAlert> createState() => _EditCommentAlertState();
}

class _EditCommentAlertState extends State<EditCommentAlert> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    contentController.text = widget.comment.content!;
  }

  @override
  void dispose() {
    super.dispose();
    widget.reloadComment();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CommentManagementBloc(
            commentRepository: context.read<CommentRepository>(),
          ),
      child: AlertDialog(
        content: BlocListener<CommentManagementBloc, CommentManagementState>(
          listener: (context, state) {
            if (state.status == CommentStatusEnum.updated) {
              Navigator.pop(context, true);
            }
          },
          child: SingleChildScrollView(
            child: BlocBuilder<CommentManagementBloc, CommentManagementState>(
              builder: (context, state) {
                if (state.status == CommentStatusEnum.loading) {
                  return const Loading();
                }
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: contentController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: "Enter your message",
                          fillColor: Colors.black12,
                          filled: true,
                          border: InputBorder.none,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        child: Text(
                          state.message ?? "",
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final postManagementBloc = BlocProvider.of<
                                  CommentManagementBloc>(context);
                              postManagementBloc.add(UpdateComment(
                                content: contentController.text,
                                commentId: widget.comment.id!,
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF626af7),
                            ),
                            child: const Text("Update"),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

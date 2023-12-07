import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/comment_management_bloc/comment_management_bloc.dart';

import '../widget/loading.dart';

class SendCommentAlert extends StatelessWidget {
  SendCommentAlert({
    super.key,
    required this.postId,
  });

  final int postId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController contentController = TextEditingController();

  void sendComment(BuildContext context) {
    final postManagementBloc = BlocProvider.of<CommentManagementBloc>(context);
    postManagementBloc.add(CreateComment(
      content: contentController.text,
      postId: postId,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: BlocBuilder<CommentManagementBloc, CommentManagementState>(
          builder: (context, state) {
            if (state.status == CommentStatusEnum.created) {
              Navigator.pop(context, true);
            }
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
                        onPressed: () => sendComment(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF626af7),
                        ),
                        child: const Text("Send"),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

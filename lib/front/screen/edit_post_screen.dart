import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/model/post.dart';
import 'package:flutter_partiel_5al/model/routes_arguments/edit_post_route_arguments.dart';

import '../../bloc/post_management_bloc/post_management_bloc.dart';
import '../../model/image_picker_controller.dart';
import '../form/image_picker_field.dart';
import '../widget/stack_loading.dart';

class EditPostScreen extends StatefulWidget {
  static const String routeName = "/editPost";

  static void navigateTo(BuildContext context, EditPostRouteArguments arguments) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  const EditPostScreen({
    super.key,
    required this.post,
    this.onDispose,
  });

  final Post post;
  final Function? onDispose;

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final ImagePickerController imagePickerController = ImagePickerController();
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = widget.post.content!;
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose!();
    }
    super.dispose();
  }

  void sendForm(BuildContext context) {
    final postManagementBloc = BlocProvider.of<PostManagementBloc>(context);
    postManagementBloc.add(Update(
      postId: widget.post.id!,
      content: textController.text,
      image: imagePickerController.image,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
      ),
      body: BlocBuilder<PostManagementBloc, PostManagementState>(
        builder: (context, state) {
          if (state.status == PostStatusEnum.updated) {
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pop();
            });
            return Container();
          }
          return StackLoading(
            loadingCondition: () {
              return state.status == PostStatusEnum.loading;
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Wrap(
                runSpacing: 16,
                children: [
                  TextField(
                    controller: textController,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      hintText: "Enter your message",
                      fillColor: Colors.black12,
                      filled: true,
                      border: InputBorder.none,
                    ),
                  ),
                  Center(
                    child: Text(
                      state.message ?? "",
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  ImagePickerField(
                    imagePickerController: imagePickerController,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => sendForm(context),
        backgroundColor: const Color(0xFF626af7),
        child: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }
}

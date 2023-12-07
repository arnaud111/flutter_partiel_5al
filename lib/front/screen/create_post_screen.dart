import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_management_bloc/post_management_bloc.dart';
import 'package:flutter_partiel_5al/front/widget/stack_loading.dart';
import 'package:flutter_partiel_5al/model/image_picker_controller.dart';
import 'package:flutter_partiel_5al/front/form/image_picker_field.dart';

import '../../bloc/post_list_bloc/post_list_bloc.dart';

class CreatePostScreen extends StatelessWidget {
  static const String routeName = "/createPost";

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  CreatePostScreen({super.key});

  final ImagePickerController imagePickerController = ImagePickerController();
  final TextEditingController textController = TextEditingController();

  void sendForm(BuildContext context) {
    final postManagementBloc = BlocProvider.of<PostManagementBloc>(context);
    postManagementBloc.add(Create(
      content: textController.text,
      image: imagePickerController.image,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
      ),
      body: BlocBuilder<PostManagementBloc, PostManagementState>(
        builder: (context, state) {
          if (state.status == PostStatusEnum.created) {
            Future.delayed(Duration.zero, () {
              final postListBloc = BlocProvider.of<PostListBloc>(context);
              postListBloc.add(GetListPost());
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

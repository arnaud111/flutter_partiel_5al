import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_management_bloc/post_management_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/model/image_picker_controller.dart';
import 'package:flutter_partiel_5al/widget/form/image_picker_field.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final ImagePickerController imagePickerController = ImagePickerController();
  final TextEditingController textController = TextEditingController();

  void sendForm() {
    final postManagementBloc = BlocProvider.of<PostManagementBloc>(context);
    postManagementBloc.add(CreatePostEvent(
      textMessage: textController.text,
      base64Image: imagePickerController.base64Image,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
      ),
      body: Padding(
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
              maxLines: 8, //or null
              decoration: const InputDecoration(
                hintText: "Enter your message",
                fillColor: Colors.black12,
                filled: true,
                border: InputBorder.none,
              ),
            ),
            BlocBuilder<PostManagementBloc, PostManagementState>(
              builder: (context, state) {
                if (state.status.status == StateStatusEnum.error) {
                  return Center(
                    child: Text(
                      state.status.message ?? "",
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            ImagePickerField(
              imagePickerController: imagePickerController,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendForm,
        backgroundColor: const Color(0xFF626af7),
        child: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }
}

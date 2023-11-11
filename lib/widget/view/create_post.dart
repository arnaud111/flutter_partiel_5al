import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_management_bloc/post_management_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/model/image_picker_controller.dart';
import 'package:flutter_partiel_5al/widget/alert/sending_post_alert.dart';
import 'package:flutter_partiel_5al/widget/form/image_picker_field.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final ImagePickerController imagePickerController = ImagePickerController();
  final TextEditingController textController = TextEditingController();

  void sendForm(BuildContext context) {
    final postManagementBloc = BlocProvider.of<PostManagementBloc>(context);
    postManagementBloc.add(CreatePostEvent(
      content: textController.text,
      image: imagePickerController.image,
    ));
    showLoadingAlert(context, postManagementBloc);
  }

  void showLoadingAlert(BuildContext context, PostManagementBloc postManagementBloc) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          BlocProvider(
            create: (BuildContext context) => postManagementBloc,
            child: const SendingPostAlert(),
          ),
      barrierDismissible: false,
    ).then((value) {
      if (postManagementBloc.state.status.status == StateStatusEnum.success) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
      ),
      body: BlocBuilder<PostManagementBloc, PostManagementState>(
        builder: (context, state) {
          return Padding(
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
                Center(
                  child: Text(
                    state.status.message ?? "",
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

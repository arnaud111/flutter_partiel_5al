import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_management_bloc/post_management_bloc.dart';
import 'package:flutter_partiel_5al/front/widget/stack_loading.dart';
import 'package:flutter_partiel_5al/model/image_picker_controller.dart';
import 'package:flutter_partiel_5al/front/form/image_picker_field.dart';
import 'package:flutter_partiel_5al/model/routes_arguments/create_post_route_arguments.dart';

class CreatePostScreen extends StatefulWidget {
  static const String routeName = "/createPost";

  static void navigateTo(BuildContext context,
      CreatePostRouteArguments arguments) {
    Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  const CreatePostScreen({
    super.key,
    this.onDispose,
  });

  final Function? onDispose;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final ImagePickerController imagePickerController = ImagePickerController();
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose!();
    }
    super.dispose();
  }

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Create Post"),
      ),
      body: BlocListener<PostManagementBloc, PostManagementState>(
        listener: (context, state) {
          if (state.status == PostStatusEnum.created) {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<PostManagementBloc, PostManagementState>(
          builder: (context, state) {
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

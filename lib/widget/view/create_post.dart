import 'package:flutter/material.dart';
import 'package:flutter_partiel_5al/widget/form/image_picker_field.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String base64Image = '';

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
            const TextField(
              maxLines: 8, //or null
              decoration: InputDecoration(
                hintText: "Enter your message",
                fillColor: Colors.black12,
                filled: true,
                border: InputBorder.none,
              ),
            ),
            ImagePickerField(
              base64Image: base64Image,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF626af7),
        child: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }
}

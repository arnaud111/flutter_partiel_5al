import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String base64Image = '';

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      List<int> imageBytes = await File(image.path).readAsBytes();
      setState(() {
        base64Image = base64Encode(Uint8List.fromList(imageBytes));
      });
    } catch (e) {
      print('Failed to pick image: $e');
    }
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
            const TextField(
              maxLines: 8, //or null
              decoration: InputDecoration(
                hintText: "Enter your message",
                fillColor: Colors.black12,
                filled: true,
                border: InputBorder.none,
              ),
            ),
            GestureDetector(
              onTap: pickImage,
              child: const Row(
                children: [
                  Text(
                    "Attach an image",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.link,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            base64Image.isEmpty
                ? Container()
                : Image.memory(
                    base64Decode(base64Image),
                    width: 160,
                    height: 160,
                  ),
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

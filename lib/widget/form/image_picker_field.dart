import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_partiel_5al/model/image_picker_controller.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerField extends StatefulWidget {
  ImagePickerField({
    super.key,
    required this.imagePickerController,
  });

  final ImagePickerController imagePickerController;

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState(() {
        widget.imagePickerController.image = File(image.path);
      });
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void resetImage() {
    setState(() {
      widget.imagePickerController.image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imagePickerController.image == null) {
      return GestureDetector(
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
      );
    }
    return SizedBox(
      width: 240,
      height: 240,
      child: Stack(
        children: [
          Center(
            child: Image.file(widget.imagePickerController.image!),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.small(
                onPressed: resetImage,
                backgroundColor: Colors.black45,
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

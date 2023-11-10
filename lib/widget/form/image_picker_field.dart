import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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
      List<int> imageBytes = await File(image.path).readAsBytes();
      setState(() {
        widget.imagePickerController.base64Image = base64Encode(Uint8List.fromList(imageBytes));
      });
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void resetImage() {
    setState(() {
      widget.imagePickerController.base64Image = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imagePickerController.base64Image.isEmpty) {
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
            child: Image.memory(
              base64Decode(widget.imagePickerController.base64Image),
            ),
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

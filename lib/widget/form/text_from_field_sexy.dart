import 'package:flutter/material.dart';

class TextFormFieldSexy extends StatelessWidget {
  const TextFormFieldSexy({
    super.key,
    required this.label,
    this.controller,
    this.obscureText = false,
    this.error = false,
  });

  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final bool error;

  Color getColor() {
    return error ? Colors.red : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: getColor(),
          ),
        ),
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      obscureText: obscureText,
    );
  }
}

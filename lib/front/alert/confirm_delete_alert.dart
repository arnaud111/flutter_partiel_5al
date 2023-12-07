import 'package:flutter/material.dart';

class ConfirmDeleteAlert extends StatelessWidget {
  const ConfirmDeleteAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Delete",
        style: TextStyle(
          color: Colors.redAccent,
        ),
      ),
      content: const Text(
        "Are you sure you want to delete this item ?",
      ),
      actions: [
        GestureDetector(
          onTap: () => Navigator.pop(context, false),
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.blueGrey,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context, true),
          child: const Text(
            "Delete",
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}

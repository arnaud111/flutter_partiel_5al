import 'package:flutter/material.dart';

class ConfirmDeleteAlert extends StatelessWidget {
  const ConfirmDeleteAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Supprimer",
        style: TextStyle(
          color: Colors.redAccent,
        ),
      ),
      content: const Text(
        "Êtes vous sûr de vouloir supprimer l'élément ?",
      ),
      actions: [
        GestureDetector(
          onTap: () => Navigator.pop(context, false),
          child: const Text(
            "Annuler",
            style: TextStyle(
              color: Colors.blueGrey,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context, true),
          child: const Text(
            "Confirmer",
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}

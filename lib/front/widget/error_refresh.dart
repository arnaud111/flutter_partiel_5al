import 'package:flutter/material.dart';

class ErrorRefresh extends StatelessWidget {
  const ErrorRefresh({
    super.key,
    required this.onRefresh,
    required this.errorMessage,
  });

  final RefreshCallback onRefresh;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        children: [
          const SizedBox(
            height: 300,
          ),
          const Icon(
            Icons.error,
            size: 64,
            color: Colors.redAccent,
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: Text(errorMessage),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_partiel_5al/front/post/row_info_author.dart';

import '../../model/comment.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.comment,
  });

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color(0xFF31363B),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowInfoAuthor(
              createdAt: comment.createdAt!,
              author: comment.author!,
            ),
            Text(comment.content!),
          ],
        ),
      ),
    );
  }

  String getDate() {
    DateTime dataTime = DateTime.fromMillisecondsSinceEpoch(comment.createdAt!);
    return "${dataTime.year}/${dataTime.month}/${dataTime.day} ${dataTime.hour}:${dataTime.minute}";
  }
}

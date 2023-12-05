import 'package:flutter/material.dart';

import '../../model/post.dart';

class PostItem extends StatelessWidget {
  PostItem({
    super.key,
    required this.post,
  });

  final Post post;

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
            Row(
              children: [
                GestureDetector(
                  onTap: () {

                  },
                  child: Text(
                    post.author?.name ?? "",
                    style: const TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  getDate(),
                  style: const TextStyle(
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
            Text(
              post.content ?? "",
            ),
            if (post.image != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16
                ),
                child: Center(
                  child: Image.network(post.image!.url!),
                ),
              ),
            GestureDetector(
              onTap: () {

              },
              child: Row(
                children: [
                  const Icon(
                    Icons.comment,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    getPostCount(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getPostCount() {
    if (post.comments == null) {
      return "0";
    }
    return "${post.comments!.length}";
  }

  String getDate() {
    DateTime dataTime = DateTime.fromMillisecondsSinceEpoch(post.createdAt!);
    return "${dataTime.year}/${dataTime.month}/${dataTime.day} ${dataTime.hour}:${dataTime.minute}";
  }
}

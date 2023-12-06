import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/post_list_user_bloc/post_list_user_bloc.dart';
import '../../model/comment.dart';
import '../view/profile.dart';

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
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => BlocProvider(
                          create: (BuildContext context) => PostListUserBloc(),
                          child: Profile(user: comment.author!),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    comment.author?.name ?? "",
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
              comment.content!
            ),
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

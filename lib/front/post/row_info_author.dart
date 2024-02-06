import 'package:flutter/material.dart';
import 'package:flutter_partiel_5al/model/user.dart';

import '../screen/profile_screen.dart';

class RowInfoAuthor extends StatelessWidget {
  const RowInfoAuthor({
    super.key,
    required this.createdAt,
    required this.author,
    this.clickableProfile = true,
  });

  final int createdAt;
  final User author;
  final bool clickableProfile;

  void onClickProfile(BuildContext context) {
    ProfileScreen.navigateTo(context, author);
  }

  String getDate() {
    DateTime dataTime = DateTime.fromMillisecondsSinceEpoch(createdAt);
    return "${dataTime.year}/${dataTime.month}/${dataTime.day} ${dataTime.hour}:${dataTime.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: clickableProfile ? () => onClickProfile(context) : null,
          child: Text(
            author.name ?? "",
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
    );
  }
}

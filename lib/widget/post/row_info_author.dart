import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/model/user.dart';

import '../../bloc/post_list_user_bloc/post_list_user_bloc.dart';
import '../view/profile.dart';

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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onClickProfile(context),
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

  void onClickProfile(BuildContext context) {
    if (clickableProfile) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider(
            create: (BuildContext context) => PostListUserBloc(),
            child: Profile(user: author),
          ),
        ),
      );
    }
  }

  String getDate() {
    DateTime dataTime = DateTime.fromMillisecondsSinceEpoch(createdAt);
    return "${dataTime.year}/${dataTime.month}/${dataTime.day} ${dataTime.hour}:${dataTime.minute}";
  }
}

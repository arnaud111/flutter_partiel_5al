import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';

import '../../bloc/post_list_user_bloc/post_list_user_bloc.dart';
import '../../model/user.dart';
import '../post/post_item.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.user});

  final User user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    super.initState();
    final postListBloc = BlocProvider.of<PostListUserBloc>(context);
    postListBloc.add(GetListPost(
      userId: widget.user.id!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          const Icon(
            Icons.account_circle,
            size: 80,
          ),
          Text(widget.user.name!),
          Text("Crée le : ${getDate()}"),
          const Divider(
            indent: 16,
            endIndent: 16,
            color: Colors.white70,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                final postListBloc = BlocProvider.of<PostListUserBloc>(context);
                postListBloc.add(GetListPost(
                  userId: widget.user.id!,
                ));
              },
              child: BlocBuilder<PostListUserBloc, PostListUserState>(
                builder: (context, state) {
                  if (state.status.status == StateStatusEnum.success) {
                    return ListView.builder(
                      itemCount: state.postList!.itemsTotal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PostItem(
                            post: state.postList!.items![index].withAuthor(widget.user),
                            clickable: false,
                          ),
                        );
                      },
                    );
                  } else if (state.status.status == StateStatusEnum.error) {
                    return Center(
                      child: Text(
                        state.status.message ?? ""
                      ),
                    );
                  }
                  return const Center(
                    child: SizedBox(
                      width: 75,
                      height: 75,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getDate() {
    DateTime dataTime =
    DateTime.fromMillisecondsSinceEpoch(widget.user.createdAt!);
    return "${dataTime.year}/${dataTime.month}/${dataTime.day}";
  }
}

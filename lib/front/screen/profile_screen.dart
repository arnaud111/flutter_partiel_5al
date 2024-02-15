import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/front/widget/error_refresh.dart';
import 'package:flutter_partiel_5al/front/widget/loading.dart';

import '../../bloc/post_list_user_bloc/post_list_user_bloc.dart';
import '../../model/user.dart';
import '../post/post_item.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "/profile";

  static void navigateTo(BuildContext context, User user) {
    Navigator.of(context).pushNamed(routeName, arguments: user);
  }

  const ProfileScreen({super.key, required this.user});

  final User user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getUserPostList();
  }

  void getUserPostList() {
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
                  switch (state.status.status) {
                    case StateStatusEnum.initial:
                      return Container();
                    case StateStatusEnum.loading:
                      return const Loading();
                    case StateStatusEnum.success:
                    case StateStatusEnum.loadingNewItems:
                      return ListView.builder(
                        itemCount: state.postList!.itemsTotal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PostItem(
                              post: state.postList!.items![index]
                                  .withAuthor(widget.user),
                              clickable: false,
                              refreshFunction: getUserPostList,
                            ),
                          );
                        },
                      );
                    case StateStatusEnum.error:
                      return ErrorRefresh(
                        onRefresh: () async {
                          getUserPostList();
                        },
                        errorMessage: state.status.message!,
                      );
                  }
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

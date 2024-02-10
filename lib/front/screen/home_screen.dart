import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_list_bloc/post_list_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/bloc/user_bloc/auth_bloc.dart';
import 'package:flutter_partiel_5al/front/drawer_profile/drawer_profile.dart';
import 'package:flutter_partiel_5al/front/post/list_post.dart';
import 'package:flutter_partiel_5al/model/routes_arguments/create_post_route_arguments.dart';

import 'create_post_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    me();
    getPostList();
  }

  void me() {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(Me());
  }

  void getPostList() {
    final authBloc = BlocProvider.of<PostListBloc>(context);
    authBloc.add(GetListPost());
  }

  void onClickFloatingButton(AuthState state, BuildContext context) {
    if (state.status.status != StateStatusEnum.success) {
      Scaffold.of(context).openDrawer();
    } else {
      CreatePostScreen.navigateTo(
        context,
        CreatePostRouteArguments(
          onDispose: getPostList,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: const DrawerProfile(),
      body: ListPost(
        refreshListFunction: getPostList,
      ),
      floatingActionButton: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () => onClickFloatingButton(state, context),
            backgroundColor: const Color(0xFF626af7),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}

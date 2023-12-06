import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_list_bloc/post_list_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/bloc/user_bloc/auth_bloc.dart';
import 'package:flutter_partiel_5al/datasource/repository/post_repository.dart';
import 'package:flutter_partiel_5al/front/drawer_profile/drawer_profile.dart';
import 'package:flutter_partiel_5al/front/post/list_post.dart';

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
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(Me());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: const DrawerProfile(),
      body: BlocProvider(
        create: (BuildContext context) => PostListBloc(
          postRepository: context.read<PostRepository>(),
        ),
        child: const ListPost(),
      ),
      floatingActionButton: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              if (state.status.status != StateStatusEnum.success) {
                Scaffold.of(context).openDrawer();
              } else {
                CreatePostScreen.navigateTo(context);
              }
            },
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

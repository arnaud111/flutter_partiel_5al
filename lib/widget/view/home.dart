import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/bloc/user_bloc/auth_bloc.dart';
import 'package:flutter_partiel_5al/widget/drawer_profile/drawer_profile.dart';

import 'create_post.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      body: const Placeholder(),
      floatingActionButton: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              if (state.status.status != StateStatusEnum.success) {
                Scaffold.of(context).openDrawer();
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreatePost(),
                  ),
                );
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

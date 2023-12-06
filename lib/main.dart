import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_detail_bloc/post_detail_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_management_bloc/post_management_bloc.dart';
import 'package:flutter_partiel_5al/bloc/user_bloc/auth_bloc.dart';
import 'package:flutter_partiel_5al/model/user.dart';
import 'package:flutter_partiel_5al/widget/screen/create_post_screen.dart';
import 'package:flutter_partiel_5al/widget/screen/post_detail_screen.dart';
import 'package:flutter_partiel_5al/widget/screen/profile_screen.dart';

import 'bloc/post_list_user_bloc/post_list_user_bloc.dart';
import 'widget/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Miku',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF31363B),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF31363B),
          ),
          scaffoldBackgroundColor: const Color(0xFF21262B),
        ),
        themeMode: ThemeMode.dark,
        routes: {
          '/': (context) => const HomeScreen(),
          CreatePostScreen.routeName: (context) =>
              BlocProvider(
                create: (context) => PostManagementBloc(),
                child: CreatePostScreen(),
              ),
        },
        onGenerateRoute: (settings) {
          Widget content = const SizedBox();

          switch (settings.name) {
            case PostDetailScreen.routeName:
              final arguments = settings.arguments;
              if (arguments is int) {
                content = BlocProvider(
                  create: (context) => PostDetailBloc(),
                  child: PostDetailScreen(postId: arguments),
                );
              }
              break;
            case ProfileScreen.routeName:
              final arguments = settings.arguments;
              if (arguments is User) {
                content = BlocProvider(
                  create: (context) => PostListUserBloc(),
                  child: ProfileScreen(user: arguments),
                );
              }
              break;
          }

          return MaterialPageRoute(builder: (context) => content);
        },
      ),
    );
  }
}

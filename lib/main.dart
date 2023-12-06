import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_detail_bloc/post_detail_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_management_bloc/post_management_bloc.dart';
import 'package:flutter_partiel_5al/bloc/user_bloc/auth_bloc.dart';
import 'package:flutter_partiel_5al/datasource/api/auth/auth_api.dart';
import 'package:flutter_partiel_5al/datasource/api/comment/comment_api.dart';
import 'package:flutter_partiel_5al/datasource/api/post/post_api.dart';
import 'package:flutter_partiel_5al/datasource/api/user/user_api.dart';
import 'package:flutter_partiel_5al/datasource/repository/auth_repository.dart';
import 'package:flutter_partiel_5al/datasource/repository/post_repository.dart';
import 'package:flutter_partiel_5al/datasource/repository/user_repository.dart';
import 'package:flutter_partiel_5al/model/user.dart';
import 'package:flutter_partiel_5al/front/screen/create_post_screen.dart';
import 'package:flutter_partiel_5al/front/screen/post_detail_screen.dart';
import 'package:flutter_partiel_5al/front/screen/profile_screen.dart';

import 'bloc/post_list_user_bloc/post_list_user_bloc.dart';
import 'datasource/repository/comment_repository.dart';
import 'front/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
            authDataSource: AuthApi(),
          ),
        ),
        RepositoryProvider(
          create: (context) => CommentRepository(
            commentDataSource: CommentApi(),
          ),
        ),
        RepositoryProvider(
          create: (context) => PostRepository(
            postDataSource: PostApi(),
          ),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(
            userDataSource: UserApi(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
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
            CreatePostScreen.routeName: (context) => BlocProvider(
                  create: (context) => PostManagementBloc(
                    postRepository: context.read<PostRepository>(),
                  ),
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
                    create: (context) => PostDetailBloc(
                      postRepository: context.read<PostRepository>(),
                    ),
                    child: PostDetailScreen(postId: arguments),
                  );
                }
                break;
              case ProfileScreen.routeName:
                final arguments = settings.arguments;
                if (arguments is User) {
                  content = BlocProvider(
                    create: (context) => PostListUserBloc(
                      userRepository: context.read<UserRepository>(),
                    ),
                    child: ProfileScreen(user: arguments),
                  );
                }
                break;
            }

            return MaterialPageRoute(builder: (context) => content);
          },
        ),
      ),
    );
  }
}

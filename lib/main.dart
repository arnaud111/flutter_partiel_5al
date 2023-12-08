import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_detail_bloc/post_detail_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_list_bloc/post_list_bloc.dart';
import 'package:flutter_partiel_5al/bloc/post_management_bloc/post_management_bloc.dart';
import 'package:flutter_partiel_5al/bloc/user_bloc/auth_bloc.dart';
import 'package:flutter_partiel_5al/datasource/api/auth/auth_api.dart';
import 'package:flutter_partiel_5al/datasource/api/comment/comment_api.dart';
import 'package:flutter_partiel_5al/datasource/api/post/post_api.dart';
import 'package:flutter_partiel_5al/datasource/api/user/user_api.dart';
import 'package:flutter_partiel_5al/datasource/repository/auth_repository.dart';
import 'package:flutter_partiel_5al/datasource/repository/post_repository.dart';
import 'package:flutter_partiel_5al/datasource/repository/user_repository.dart';
import 'package:flutter_partiel_5al/front/screen/edit_post_screen.dart';
import 'package:flutter_partiel_5al/model/routes_arguments/create_post_route_arguments.dart';
import 'package:flutter_partiel_5al/model/routes_arguments/edit_post_route_arguments.dart';
import 'package:flutter_partiel_5al/model/routes_arguments/post_detail_route_arguments.dart';
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
          BlocProvider(
            create: (BuildContext context) => PostListBloc(
              postRepository: context.read<PostRepository>(),
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
          },
          onGenerateRoute: (settings) {
            Widget content = const SizedBox();

            final arguments = settings.arguments;
            switch (settings.name) {
              case CreatePostScreen.routeName:
                if (arguments is CreatePostRouteArguments) {
                  content = BlocProvider(
                    create: (context) => PostManagementBloc(
                      postRepository: context.read<PostRepository>(),
                    ),
                    child: CreatePostScreen(
                      onDispose: arguments.onDispose,
                    ),
                  );
                }
                break;
              case PostDetailScreen.routeName:
                if (arguments is PostDetailRouteArguments) {
                  content = MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => PostDetailBloc(
                          postRepository: context.read<PostRepository>(),
                        ),
                      ),
                      BlocProvider(
                        create: (context) => PostManagementBloc(
                          postRepository: context.read<PostRepository>(),
                        ),
                      ),
                    ],
                    child: PostDetailScreen(
                      postId: arguments.postId,
                      onDispose: arguments.onDispose,
                    ),
                  );
                }
                break;
              case ProfileScreen.routeName:
                if (arguments is User) {
                  content = BlocProvider(
                    create: (context) => PostListUserBloc(
                      userRepository: context.read<UserRepository>(),
                    ),
                    child: ProfileScreen(user: arguments),
                  );
                }
                break;
              case EditPostScreen.routeName:
                if (arguments is EditPostRouteArguments) {
                  content = BlocProvider(
                    create: (context) => PostManagementBloc(
                      postRepository: context.read<PostRepository>(),
                    ),
                    child: EditPostScreen(
                      post: arguments.post,
                      onDispose: arguments.onDispose,
                    ),
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

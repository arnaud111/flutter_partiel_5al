import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/user_bloc/auth_bloc.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: BlocProvider(
        create: (context) => AuthBloc(),
        child: const MaterialApp(
          home: MyHomePage(),
        ),
      ),
    );
  }
}

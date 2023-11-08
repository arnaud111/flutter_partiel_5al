import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/user_bloc/auth_bloc.dart';
import 'package:flutter_partiel_5al/widget/auth/login_alert.dart';
import 'package:flutter_partiel_5al/widget/auth/signup_alert.dart';

class DrawerColumnDisconnected extends StatelessWidget {
  const DrawerColumnDisconnected({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xFF31363B),
          ),
          child: Center(
            child: Icon(
              Icons.account_circle,
              size: 80,
            ),
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => showLoginAlert(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF626af7),
              ),
              child: const Text("Login"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => showSignupAlert(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF626af7),
              ),
              child: const Text("Signup"),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(),
        ),
      ],
    );
  }

  void showLoginAlert(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => const LoginAlert(),
    );
  }

  void showSignupAlert(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => const SignupAlert(),
    );
  }
}

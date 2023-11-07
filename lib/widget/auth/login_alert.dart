import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user_bloc/auth_bloc.dart';

class LoginAlert extends StatefulWidget {
  const LoginAlert({super.key});

  @override
  State<LoginAlert> createState() => _LoginAlertState();
}

class _LoginAlertState extends State<LoginAlert> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    if (_formKey.currentState!.validate()) {
      final authBloc = BlocProvider.of<AuthBloc>(context);
      authBloc.add(Login(
        email: emailController.text,
        password: passwordController.text,
      ));
    }
  }

  String? textEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please, fill this input';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            validator: textEmptyValidator,
            controller: emailController,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
          TextFormField(
            validator: textEmptyValidator,
            controller: passwordController,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.white),
            ),
            obscureText: true,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF626af7),
                ),
                child: const Text("Login"),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

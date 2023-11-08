import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';

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

  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(Init());
  }

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
      content: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.status.status == StateStatusEnum.success) {
            Navigator.pop(context);
          }
          if (state.status.status == StateStatusEnum.loading) {
            return const SizedBox(
              width: 75,
              height: 75,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Form(
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
                    top: 8.0,
                  ),
                  child: Text(
                    state.status.message ?? "",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
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
          );
        },
      ),
    );
  }
}

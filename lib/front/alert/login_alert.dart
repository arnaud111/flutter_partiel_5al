import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/front/form/text_from_field_sexy.dart';
import 'package:flutter_partiel_5al/front/widget/loading.dart';

import '../../bloc/user_bloc/auth_bloc.dart';

class LoginAlert extends StatefulWidget {
  const LoginAlert({super.key});

  @override
  State<LoginAlert> createState() => _LoginAlertState();
}

class _LoginAlertState extends State<LoginAlert> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(Init());
  }

  void login() {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(Login(
      email: emailController.text,
      password: passwordController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.status.status == StateStatusEnum.success) {
              Navigator.pop(context);
            }
            if (state.status.status == StateStatusEnum.loading) {
              return const Loading();
            }
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormFieldSexy(
                    label: 'Email',
                    controller: emailController,
                    error: state.status.payload?["param"] == "email",
                  ),
                  TextFormFieldSexy(
                    label: 'Password',
                    controller: passwordController,
                    error: state.status.payload?["param"] == "password",
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: Text(
                      state.status.message ?? "",
                      style: const TextStyle(
                        color: Colors.red,
                      ),
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
      ),
    );
  }
}

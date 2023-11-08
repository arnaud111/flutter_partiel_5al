import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/user_bloc/auth_bloc.dart';

import '../../bloc/state_status.dart';

class SignupAlert extends StatefulWidget {
  const SignupAlert({super.key});

  @override
  State<SignupAlert> createState() => _SignupAlertState();
}

class _SignupAlertState extends State<SignupAlert> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(Init());
  }

  void signup() {
    if (_formKey.currentState!.validate()) {
      final authBloc = BlocProvider.of<AuthBloc>(context);
      authBloc.add(Signup(
        name: nameController.text,
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

  String? passwordValidator(String? value) {
    if (value == null || value.length < 8) {
      return 'Password must contain at least 8 characters';
    }
    return null;
  }

  String? passwordConfirmValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please, fill this input';
    }
    if (passwordController.text != value) {
      return 'Must be the same that the password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.status == StateStatus.success) {
              Navigator.pop(context);
            }
            if (state.status == StateStatus.loading) {
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
                    controller: emailController,
                    validator: textEmptyValidator,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: textEmptyValidator,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: passwordValidator,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: passwordConfirmController,
                    validator: passwordConfirmValidator,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: 'Confirm Password',
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
                      top: 16,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: signup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF626af7),
                        ),
                        child: const Text("Signup"),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )
    );
  }
}
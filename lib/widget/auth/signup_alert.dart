import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_partiel_5al/bloc/user_bloc/auth_bloc.dart';

import '../../bloc/state_status.dart';
import '../form/text_from_field_sexy.dart';

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
        content: SingleChildScrollView(
          child: BlocBuilder<AuthBloc, AuthState>(
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
                    TextFormFieldSexy(
                      label: 'Email',
                      controller: emailController,
                      error: state.status.payload?["param"] == "email",
                    ),
                    TextFormFieldSexy(
                      label: 'Name',
                      controller: nameController,
                      error: state.status.payload?["param"] == "name",
                    ),
                    TextFormFieldSexy(
                      label: 'Password',
                      controller: passwordController,
                      error: state.status.payload?["param"] == "password",
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
          ),
        )
    );
  }
}
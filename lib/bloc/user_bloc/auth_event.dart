part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class Me extends AuthEvent {}

class Login extends AuthEvent {
  final String email;
  final String password;

  Login({
    required this.email,
    required this.password,
  });
}

class Signup extends AuthEvent {
  final String email;
  final String name;
  final String password;
  final String validatePassword;

  Signup({
    required this.email,
    required this.name,
    required this.password,
    required this.validatePassword,
  });
}

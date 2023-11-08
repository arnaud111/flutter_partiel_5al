part of 'auth_bloc.dart';

class AuthState {
  Auth? auth;
  StateStatus status;

  AuthState({
    this.auth,
    required this.status,
  });

  AuthState copyWith({
    StateStatus? status,
    Auth? auth,
  }) {
    return AuthState(status: status ?? this.status, auth: auth ?? this.auth);
  }
}

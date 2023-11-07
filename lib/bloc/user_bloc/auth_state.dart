part of 'auth_bloc.dart';

class AuthState {
  Auth? auth;
  StateStatus status;

  AuthState({
    this.auth,
    this.status = StateStatus.initial,
  });

  AuthState copyWith({
    StateStatus? status,
    Auth? auth,
  }) {
    return AuthState(status: status ?? this.status, auth: auth ?? this.auth);
  }
}

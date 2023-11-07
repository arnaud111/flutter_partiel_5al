part of 'auth_bloc.dart';

class AuthState {
  Auth? user;
  StateStatus status;

  AuthState({
    this.user,
    this.status = StateStatus.initial,
  });

  AuthState copyWith({
    StateStatus? status,
    Auth? user,
  }) {
    return AuthState(status: status ?? this.status, user: user ?? this.user);
  }
}

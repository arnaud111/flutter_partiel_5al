import 'package:bloc/bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:meta/meta.dart';

import '../../model/auth.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<Me>(_onMe);
  }

  void _onMe(Me event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      status: StateStatus.loading,
    ));
  }
}

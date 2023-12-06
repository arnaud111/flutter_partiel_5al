import 'package:bloc/bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/datasource/repository/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../datasource/api/http_error.dart';
import '../../model/auth.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthState(status: StateStatus.initial())) {
    on<Me>(_onMe);
    on<Init>(_onInit);
    on<Disconnect>(_onDisconnect);
    on<Login>(_onLogin);
    on<Signup>(_onSignup);
  }

  void _onInit(Init event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      status: StateStatus.initial(),
      auth: null,
    ));
  }

  void _onMe(Me event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      status: StateStatus.loading(),
    ));

    try {
      Auth auth = await authRepository.me();

      emit(state.copyWith(
        status: StateStatus.success(),
        auth: auth,
      ));
    } on HttpError catch (e) {
      emit(state.copyWith(
        status: StateStatus.error(
          message: e.message,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StateStatus.error(
          message: "Error, please retry later !",
        ),
      ));
    }
  }

  void _onDisconnect(Disconnect event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      status: StateStatus.initial(),
      auth: null,
    ));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("auth_token");
  }

  void _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      status: StateStatus.loading(),
    ));

    try {
      String token = await authRepository.login(event.email, event.password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("auth_token", token);

      Auth auth = await authRepository.me();

      emit(state.copyWith(
        status: StateStatus.success(),
        auth: auth,
      ));
    } on HttpError catch (e) {
      emit(state.copyWith(
        status: StateStatus.error(
          message: e.message,
          payload: e.payload,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StateStatus.error(
          message: "Error, please retry later !",
        ),
      ));
    }
  }

  void _onSignup(Signup event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      status: StateStatus.loading(),
    ));

    try {
      String token =
          await authRepository.signup(event.name, event.email, event.password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("auth_token", token);

      Auth auth = await authRepository.me();

      emit(state.copyWith(
        status: StateStatus.success(),
        auth: auth,
      ));
    } on HttpError catch (e) {
      emit(state.copyWith(
        status: StateStatus.error(
          message: e.message,
          payload: e.payload,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StateStatus.error(
          message: "Error, please retry later !",
        ),
      ));
    }
  }
}

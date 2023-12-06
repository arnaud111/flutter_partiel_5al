import '../../model/auth.dart';
import '../abstract/auth_datasource.dart';

class AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepository({required this.authDataSource});

  Future<Auth> me() async {
    return authDataSource.me();
  }

  Future<String> login(String email, String password) async {
    return authDataSource.login(email, password);
  }

  Future<String> signup(String name, String email, String password) async {
    return authDataSource.signup(name, email, password);
  }
}

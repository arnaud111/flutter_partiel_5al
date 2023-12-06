
import '../../model/auth.dart';

abstract class AuthDataSource {

  Future<Auth> me();

  Future<String> login(String email, String password);

  Future<String> signup(String name, String email, String password);
}

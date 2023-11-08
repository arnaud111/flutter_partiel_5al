import 'package:flutter_partiel_5al/api/api.dart';
import 'package:flutter_partiel_5al/api/http_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/auth.dart';

class AuthApi extends Api {

  static Future<Auth> me() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Api.dio.options.headers["Authorization"] = "Bearer ${prefs.getString('auth_token')}";
    final response = await Api.dio.get("/auth/me");
    if (response.statusCode != 200) {
      throw HttpError.fromJson(response.data);
    }
    return Auth.fromJson(response.data);
  }

  static Future<String> login(String email, String password) async {
    final response = await Api.dio.post("/auth/login", data: {
      "email": email,
      "password": password,
    });
    if (response.statusCode != 200) {
      throw HttpError.fromJson(response.data);
    }
    return response.data["authToken"];
  }

  static Future<String> signup(String name, String email, String password) async {
    final response = await Api.dio.post("/auth/signup", data: {
      "name": name,
      "email": email,
      "password": password,
    });
    if (response.statusCode != 200) {
      throw HttpError.fromJson(response.data);
    }
    return response.data["authToken"];
  }
}
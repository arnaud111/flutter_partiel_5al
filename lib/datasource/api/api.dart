import 'package:dio/dio.dart';

class Api {
  static final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      baseUrl: "https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi",
      validateStatus: (int? status) {
        return true;
      },
    ),
  );
}

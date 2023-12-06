class HttpError implements Exception {
  String? code;
  String? message;
  Map<String, dynamic>? payload;

  HttpError({
    this.code,
    this.message,
    this.payload,
  });

  static HttpError fromJson(Map<String, dynamic> json) {
    return HttpError(
      code: json['code'],
      message: json['message'],
      payload: json['payload'],
    );
  }
}
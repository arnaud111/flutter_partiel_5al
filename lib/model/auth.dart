class Auth {
  int? id;
  String? createdAt;
  String? name;
  String? email;

  Auth({
    this.id,
    this.createdAt,
    this.name,
    this.email,
  });

  static Auth fromJson(Map<String, dynamic> json) {
    return Auth(
      id: json['id'],
      createdAt: json['createdAt'],
      name: json['name'],
      email: json['email'],
    );
  }
}

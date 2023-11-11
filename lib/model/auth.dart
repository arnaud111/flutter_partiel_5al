class Auth {
  int? id;
  int? createdAt;
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
      createdAt: json['created_at'],
      name: json['name'],
      email: json['email'],
    );
  }
}

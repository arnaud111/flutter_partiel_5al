class User {
  int? id;
  String? createdAt;
  String? name;

  User({
    this.id,
    this.createdAt,
    this.name,
  });

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      createdAt: json['created_at'],
      name: json['name'],
    );
  }
}
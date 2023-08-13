
class User {
  final int id;
  final String email;
  final String role;

  User(
    this.id,
    this.email,
    this.role,
  );

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        role = json['role']
        ;

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'role': role,
      };
}
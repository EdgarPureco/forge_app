
class Supplier {
  final int id;
  final String name;
  final String email;
  final String phone;

  Supplier(
    this.id,
    this.name,
    this.email,
    this.phone,
  );

  Supplier.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone']
        ;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
      };
}
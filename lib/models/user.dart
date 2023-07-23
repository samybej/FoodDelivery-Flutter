class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final int orderCount;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.orderCount});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['f_name'],
      email: json['email'],
      phone: json['phone'],
      orderCount: json['order_count'],
    );
  }
}

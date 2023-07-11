import 'package:flutter/material.dart';

@immutable
class User {
  final String name;
  final String phone;
  final String email;
  final String password;

  const User(
      {required this.name,
      required this.phone,
      required this.email,
      required this.password});

  Map<String, dynamic> toJson() {
    return {
      "f_name": name,
      "phone": phone,
      "email": email,
      "password": password,
    };
  }
}

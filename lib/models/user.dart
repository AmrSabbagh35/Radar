// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class User {
  final String username;
  final String email;

  User({
    required this.username,
    required this.email,
  });

  User copyWith({
    String? username,
    String? email,
  }) =>
      User(
        username: username ?? this.username,
        email: email ?? this.email,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
      };
}

// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

class Profile {
  final int id;
  final String phone;
  final String fullName;
  final int age;
  final String image;
  final String address;
  final String illnesses;
  final int familyMembers;
  final double latitude;
  final double longitude;

  Profile({
    required this.id,
    required this.phone,
    required this.fullName,
    required this.age,
    required this.image,
    required this.address,
    required this.illnesses,
    required this.familyMembers,
    required this.latitude,
    required this.longitude,
  });

  Profile copyWith({
    int? id,
    String? phone,
    String? fullName,
    int? age,
    String? image,
    String? address,
    String? illnesses,
    int? familyMembers,
    double? latitude,
    double? longitude,
  }) =>
      Profile(
        id: id ?? this.id,
        phone: phone ?? this.phone,
        fullName: fullName ?? this.fullName,
        age: age ?? this.age,
        image: image ?? this.image,
        address: address ?? this.address,
        illnesses: illnesses ?? this.illnesses,
        familyMembers: familyMembers ?? this.familyMembers,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        phone: json["phone"],
        fullName: json["full_name"],
        age: json["age"],
        image: json["image"],
        address: json["address"],
        illnesses: json["illnesses"],
        familyMembers: json["family_members"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "full_name": fullName,
        "age": age,
        "image": image,
        "address": address,
        "illnesses": illnesses,
        "family_members": familyMembers,
        "latitude": latitude,
        "longitude": longitude,
      };
}

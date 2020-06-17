// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.message,
    this.token,
    this.user,
  });

  String message;
  String token;
  User user;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    message: json["message"],
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
    "user": user.toJson(),
  };
}

class User {
  User({
    this.id,
    this.email,
    this.name,
  });

  int id;
  String email;
  String name;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
  };
}

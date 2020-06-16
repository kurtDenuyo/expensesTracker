import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class loginUsers {
  String name;
  String email;
  String message;
  String id;
  String token;

  loginUsers({this.name, this.email, this.message, this.id, this.token});

  loginUsers fromJson(Map<String, dynamic> json) {
    return loginUsers(
        name: json['name'] as String,
        email: json['email'] as String,
        message: json['message'] as String,
        token: json['token'] as String,
        id: json['id'] as String
    );
  }

}
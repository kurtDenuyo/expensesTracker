import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()

class User {
  String username;
  String email;
  String password;
  User(
  {
    @required this.username,
    @required this.email,
    @required this.password
  }

      );

  Map<String, dynamic> toJson() => _$userToJson(this);
}
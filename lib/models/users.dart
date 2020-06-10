import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()

class User {
  String name;
  String email;
  String password;
  User(
  {
    @required this.name,
    @required this.email,
    @required this.password
  }
  );
  Map<String, dynamic> toJson() => _$userToJson(this);
}
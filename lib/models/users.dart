import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()

class RegisterUser {
  String name;
  String email;
  String password;
  RegisterUser(
  {
    @required this.name,
    @required this.email,
    @required this.password
  }
  );
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
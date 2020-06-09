// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$userFromJson(Map<String, dynamic> json) {
  return User(
    username: json['username'] as String,
    email: json['email'] as String,
    password: json['password'] as String
  );
}

Map<String, dynamic> _$userToJson(User instance) =>
    <String, dynamic>{
      '_username': instance.username,
      '_email': instance.email,
      '_password': instance.password
    };
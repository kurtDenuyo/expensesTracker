// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterUser _$UserFromJson(Map<String, dynamic> json) {
  return RegisterUser(
    name: json['name'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UserToJson(RegisterUser instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
    };

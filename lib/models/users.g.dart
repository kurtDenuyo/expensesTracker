
part of 'users.dart';

Map<String, dynamic> _$userToJson(User instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password
    };
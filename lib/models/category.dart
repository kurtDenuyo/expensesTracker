import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class category {
  String name;
  String id;
  String icon;
  category({this.name, this.id, this.icon});

  category fromJson(Map<String, dynamic> json) {
    return category(
        name: json['name'] as String,
        id: json['id'] as String,
        icon: json['icon'] as String
    );
  }

}
import 'dart:convert';

import 'package:expensestracker/models/category.dart';
import 'package:expensestracker/models/users.dart';
import 'package:http/http.dart' as http;
import 'api_response.dart';

class dataProvider {
  static const API = 'http://expenses.koda.ws/';

  Future<http.Response> addUser(User user) {
    return http.post(
        API + 'api/v1/sign_up',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(user.toJson())
    );
  }
  Future<http.Response> loginUser(String email, String password) {
    return http.post(
        API + 'api/v1/sign_in',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, String>{
          'email': email,
          'password': password
        })
    );
  }

  Future<http.Response> fetchCategory() {
    return http.get(
      API + 'api/v1/categories',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
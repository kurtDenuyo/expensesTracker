import 'dart:convert';
import 'dart:io';
import 'package:expensestracker/models/Records.dart';
import 'package:expensestracker/models/categoryModel.dart';
import 'package:expensestracker/models/recentFiveRecords.dart';
import 'package:expensestracker/models/successUsers.dart';
import 'package:expensestracker/models/users.dart';
import 'package:http/http.dart' as http;


class dataProvider {
  static const API = 'http://expenses.koda.ws/';
  String _token = "f";

  token(String value) {
    _token = value;
  }

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
    final result = http.post(
        API + 'api/v1/sign_in',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, String>{
          'email': email,
          'password': password
        }));
    return result;
  }
  Future<http.Response> addRecord(Map record, loginUsers currentUsers) {
    _token = currentUsers.token;
    //print(_token);
   // print(record);
    return http.post(
        API + 'api/v1/records',
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $_token"
        },
        body:json.encode(record)
    );
  }

  Future<RecordsModel> fetchRecords(loginUsers currentUsers) async{
    _token = currentUsers.token;
    final response = await http.get(
      API + 'api/v1/records',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_token"
      },
    );

    //print("Response "+response.body);
    //print("Token "+_token);

    final result = recordsModelFromJson(response.body);
   // print("result from json"+result.records[1].amount.toString());
    return result;
  }
  Future<RecentFiveRecords> fetchFiveRecords(loginUsers currentUsers) async{
    _token = currentUsers.token;
    final response = await http.get(
      API + 'api/v1/records?limit=5',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_token"
      },
    );

    print("Response "+response.body);
    print("Token "+_token);

    final result = recentFiveRecordsFromJson(response.body);
    print("result from json"+result.records[1].amount.toString());
    return result;
  }
  Future<CategoryModel> fetchCategory() async{
    final result = await http.get(
      API + 'api/v1/categories',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final category = categoryModelFromJson(result.body);
    return category;
  }
}
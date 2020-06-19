import 'dart:convert';
import 'dart:io';
import 'package:expensestracker/models/Records.dart';
import 'package:expensestracker/models/categoryModel.dart';
import 'package:expensestracker/models/overview.dart';
import 'package:expensestracker/models/recentFiveRecords.dart';
import 'package:expensestracker/models/users.dart';
import 'package:expensestracker/models/usersModel.dart';
import 'package:expensestracker/views/editRecord.dart';
import 'package:http/http.dart' as http;


class dataProvider {
  static const API = 'http://expenses.koda.ws/';
  String _token = "";

  token(String value) {
    _token = value;
  }

  Future<http.Response> addUser(RegisterUser user) async{
    final response = await http.post(
        API + 'api/v1/sign_up',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(user.toJson()));
    return response;

  }
  Future<UserModel> loginUser(String email, String password) async{
    final response = await http.post(
        API + 'api/v1/sign_in',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, String>{
          'email': email,
          'password': password
        }));
    final result = userModelFromJson(response.body);
    //print(result.records.length.toString());
    //print("result from json"+result.records[1].amount.toString());
    return result;
  }
  Future<http.Response> addRecord(Map record, UserModel currentUsers) {
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

  Future<RecordsModel> fetchRecords(UserModel currentUsers) async{
    _token = currentUsers.token;
    final response = await http.get(
      API + 'api/v1/records',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_token"
      },
    );

    //print("Response content "+response.body);
    //print("Token "+_token);

    final result = recordsModelFromJson(response.body);
    //print(result.records.length.toString());
    //print("result from json"+result.records[1].amount.toString());
    return result;
  }
  Future<Overview> fetchOverview(UserModel currentUsers) async{
    _token = currentUsers.token;
    final response = await http.get(
      API + 'api/v1/records/overview',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_token"
      },
    );

    //print("Response content "+response.body);
    //print("Token "+_token);

    final result = overviewFromJson(response.body);
    //print(result.records.length.toString());
    //print("result from json"+result.records[1].amount.toString());
    return result;
  }
  Future<RecentFiveRecords> fetchFiveRecords(UserModel currentUsers) async{
    _token = currentUsers.token;
    final response = await http.get(
      API + 'api/v1/records?limit=5',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_token"
      },
    );

    //print("Response "+response.body);
    //print("Token "+_token);

    final result = recentFiveRecordsFromJson(response.body);
    //print("result from json"+result.records[1].amount.toString());
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
  Future<http.Response> editRecord(Map record, UserModel currentUsers, String recordId) async{
    _token = currentUsers.token;
    final response = await http.patch(
      API + 'api/v1/records/' + recordId,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $_token"
      },
        body:json.encode(record)
    );
   return response;
  }
  Future<http.Response> deleteRecord(UserModel currentUsers, String recordId) async{
    _token = currentUsers.token;
    print("User id "+ currentUsers.user.id.toString());
     print("record Id "+ recordId);
    print("user token  "+ currentUsers.token);
     final response = await http.delete(
       API + 'api/v1/records/' + recordId,
       headers: {
         HttpHeaders.contentTypeHeader: "application/json",
         HttpHeaders.authorizationHeader: "Bearer $_token"
       },
     );

    return response;
  }
  Future<RecordsModel> searchRecord(UserModel currentUsers, String searchKeyword) async{
    _token = currentUsers.token;
    final response = await http.get(
      API + 'api/v1/records?q=' + searchKeyword,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_token"
      },
    );

    //print("Response content "+response.body);
    //print("Token "+_token);

    final result = recordsModelFromJson(response.body);
    //print(result.records.length.toString());
    //print("result from json"+result.records[1].amount.toString());
    return result;
  }

  Future<RecordsModel> seed(UserModel currentUsers, String url) async{
    _token = currentUsers.token;
    final response = await http.get(
      API + url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_token"
      },
    );

    //print("Response content "+response.body);
    //print("Token "+_token);

    final result = recordsModelFromJson(response.body);
    //print(result.records.length.toString());
    //print("result from json"+result.records[1].amount.toString());
    return result;
  }
}
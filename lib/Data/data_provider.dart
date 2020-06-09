import 'dart:convert';

import 'package:expensestracker/models/users.dart';
import 'package:http/http.dart' as http;
import 'api_response.dart';

class dataProvider {
  static const API = 'http://petstore.swagger.io/v1';

  Future<APIResponse<bool>> addUser(User user)
  {
    return http.post(API + '/users/', body: json.encode(user.toJson())).then((data)
    {
      if (data.statusCode == 201)
      {
        print("status code 201");

        return APIResponse<bool>(data: true);

      }
      print(data.statusCode);
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}

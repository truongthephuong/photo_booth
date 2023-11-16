import 'dart:convert';
import 'dart:io';

import '../data_sources/api_urls.dart';
// import '../models/api_error.dart';
// import '../models/api_response.dart';
// import '../models/users.dart';
import 'package:http/http.dart' as http;

/*
Future<ApiResponse>? authenticateUser(String username, String password) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final http.Response response = await http.post(
      ApiUrls().API_USER_LOGIN,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:  jsonEncode(<String, String>{
          'email': username,
          'password': password,
        }),
    );
    print('result from api ');
    print(response.body);
    print(response.statusCode);

    switch (response.statusCode) {
      case 201:
        apiResponse.Data = Users.fromJson(json.decode(response.body));
        print('vao day 1 ');
        //_apiResponse.Data = response.body;
        break;
      case 401:
        print('vao day 2');
        apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        print('vao day 3');
        apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return apiResponse;
}

 */
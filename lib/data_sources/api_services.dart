import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/api_error.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../models/users.dart';
import '../models/contents.dart';
import '../models/detail_content.dart';
import 'api_urls.dart';

class ApiServices{
  //For fetching user from database to list
  Future<List<User>> fetchUser() {
    return http
        .get(ApiUrls().API_USER_LIST)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if(statusCode != 200 || jsonBody == null){
        print(response.reasonPhrase);
        throw new Exception("Lỗi load api");
      }

      final JsonDecoder _decoder = new JsonDecoder();
      final useListContainer = _decoder.convert(jsonBody);
      final List userList = useListContainer['results'];
      return userList.map((contactRaw) => new User.fromJson(contactRaw)).toList();
    });
  }

  //For user login function
  Future<ApiResponse>? userLogin(String username, String password ) async {
    ApiResponse _apiResponse = new ApiResponse();

    try {
      final http.Response response = await http.post(
        ApiUrls().API_USER_LOGIN,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': username,
          'password': password,
        }),
      );

      //print('result from api ');
      print(response.body);

      switch (response.statusCode) {
        case 201:
          _apiResponse.Data = Users.fromJson(json.decode(response.body));
          print('vao day 1 ');
          //_apiResponse.Data = response.body;
          break;
        case 401:
          print('vao day 2');
          _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
          break;
        default:
          print('vao day 3');
          _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
          break;
      }
    } on SocketException {
      _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
    }
    return _apiResponse;
  }

  //For get detail of user
  Future<ApiResponse> getUserDetails(String userId) async {
    ApiResponse _apiResponse = new ApiResponse();
    final _baseUrl = ApiUrls().API_USER_LIST;
    final JsonDecoder _decoder = new JsonDecoder();
    try {
      final response = await http.get('${_baseUrl}/$userId' as Uri);

      switch (response.statusCode) {
        case 200:
          _apiResponse.Data = User.fromJson(_decoder.convert(response.body));
          break;
        case 401:
          print((_apiResponse.ApiError as ApiError).error);
          _apiResponse.ApiError = ApiError.fromJson(_decoder.convert(response.body));
          break;
        default:
          print((_apiResponse.ApiError as ApiError).error);
          _apiResponse.ApiError = ApiError.fromJson(_decoder.convert(response.body));
          break;
      }
    } on SocketException {
      _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
    }
    return _apiResponse;
  }

  Future<List<Contents>> fetchContents() async {
    return await http
        .get(ApiUrls().API_CONTENTS_LIST)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if(statusCode != 200 || jsonBody == null){
        print(response.reasonPhrase);
        throw new Exception("Lỗi load api");
      }

      final JsonDecoder _decoder = new JsonDecoder();
      final contentsListContainer = _decoder.convert(jsonBody);
      final List contentsList = contentsListContainer['contents'];
      //print('list data on service');
      //print(contentsList);
      return contentsList.map((contactRaw) => new Contents.fromJson(contactRaw)).toList();
    });
  }

  Future<DetailContents>? fetchDetailContents(int conId) async {
    ApiResponse _apiResponse = new ApiResponse();
    final _baseUrl = ApiUrls().API_DEAITL_CONTENTS;
    final JsonDecoder _decoder = new JsonDecoder();
    final apiUrl = '${_baseUrl}?id=${conId}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      final String jsonBody = response.body;
      final contentsContainer = _decoder.convert(jsonBody);
      print('list data on service');
      print(contentsContainer);
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return DetailContents.fromJson(contentsContainer['contents'] );
        //return jsonDecode(response.body).map<DetailContents>((object) => DetailContents.fromJson(object)).toList();
        //return DetailContents.fromJson(response.body as Map<String, dynamic>);

      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } on SocketException {
      throw Exception("Server error. Please retry");
    }

  }

  Future<List<Contents>> fetchContentsByCate(int cateId) async {
    //print('API url ');
    var baseUrl = ApiUrls().API_CONTENTS_LIST_BY_CATE;
    var paramUrl = '?page=1&perPage=10&cateId=$cateId';
    final Uri apiUrl = Uri.parse('$baseUrl$paramUrl');
    //print(apiUrl);
    return await http
        .get(apiUrl)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if(statusCode != 200 || jsonBody == null){
        print(response.reasonPhrase);
        throw new Exception("Lỗi load api");
      }

      final JsonDecoder _decoder = new JsonDecoder();
      final contentsListContainer = _decoder.convert(jsonBody);
      final List contentsList = contentsListContainer['contents'];
      //print('list data on service');
      //print(contentsListContainer['contents']);
      //print(contentsList);
      return contentsList.map((contactRaw) => new Contents.fromJson(contactRaw)).toList();
    });
  }


}
import 'dart:io';

import 'package:dio/dio.dart';

import '../util/exception_handler.dart';
import '../services/dio_client.dart';

class CustomerLoginApi {
  DioClient _dioClient =
  DioClient("http://192.168.71.31:1880", Dio(), headers: {
    HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
    'twanapikey': "22190e43-14cf-4b4c-90f2-ec18d2e1ad63"
  });

  //"final String _baseUrl = 'http://192.168.100.39:8089/gateway/telemedicine/V1.0/TawnTeleMedicine/restful';
  //final String _baseUrl = 'https://tapis.fasah.sa/api/resrt';
  //final String _baseUrl = 'http://192.168.100.91:1400/api/resrt';

  Future<LoginResponse> login(LoginRequest request) async {

    print('on login');
    Map<String, dynamic> requestMap = request.toJson();

    final response = await _dioClient.post("/test", data: requestMap);
    print('response here');
    LoginResponse loginResponse =
    LoginResponse.fromJson(response);
    print('loginResponse${loginResponse.token}');
    return loginResponse;
  }

}
class LoginResponse {
     String statusCode='';
    String token='';

 LoginResponse(
      {required this.statusCode, required this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    this.token = json['token'];
    this.statusCode = json['statusCode'];
    print('loginResponse$this.token');
  }
}

class LoginRequest {
  final String userName;
  final String password;
  final String lang_code;

  LoginRequest(
      {required this.userName, required this.password, required this.lang_code});

  Map<String, dynamic> toJson() {
    print('on toJson');
    final Map<String, dynamic> jsonObject = new Map<String, dynamic>();

    jsonObject["userName"] = this.userName;
    jsonObject["password"] = this.password;
    jsonObject["lang_code"] = this.lang_code;

    return jsonObject;
  }
}

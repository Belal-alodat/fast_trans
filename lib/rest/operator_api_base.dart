import 'dart:io';

import 'package:dio/dio.dart';

import '../services/dio_client.dart';
import 'auth_api_base.dart';

class OperatorAPI {
  DioClient? dioClient ;

  OperatorAPI(String token) {
    dioClient = DioClient(AuthAPI.baseUrl, Dio(), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
       HttpHeaders.authorizationHeader: 'Bearer $token',
    });
  }

  //  static const String _baseUrl = 'http://192.168.100.39:1990/suppliers';
 // static const String _baseUrl = 'http://192.168.100.39:1990';

}

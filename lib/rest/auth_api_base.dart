import 'dart:io';

import 'package:dio/dio.dart';

import '../services/dio_client.dart';

class AuthAPI {
  final DioClient dioClient = DioClient(AuthAPI.baseUrl, Dio(), headers: {
    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
    //HttpHeaders.authorizationHeader:'Bearer ${AppSession.instance.token}',
  });

  //static const String _baseUrl = 'http://192.168.100.39:1990/auth';
  static const String baseUrl = 'http://192.168.100.109:5000';

  //static const String baseUrl = 'http://fasttrans-env.eba-x83wwcgk.us-east-1.elasticbeanstalk.com';
}

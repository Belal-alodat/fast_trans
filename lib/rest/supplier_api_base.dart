import 'dart:io';

import 'package:dio/dio.dart';

import '../core/app_session.dart';
import '../services/dio_client.dart';

class SupplierAPI {
  DioClient? dioClient ;

  SupplierAPI(String token) {
    dioClient = DioClient(_baseUrl, Dio(), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
  }

    static const String _baseUrl = 'http://192.168.100.39:1990/suppliers';

}

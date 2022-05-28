import 'dart:io';

import 'package:dio/dio.dart';

import '../core/app_session.dart';
import '../services/dio_client.dart';

class SupplierAPI {
  final DioClient dioClient = DioClient(_baseUrl, Dio(), headers: {
    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    HttpHeaders.authorizationHeader:'Bearer ${AppSession.instance.token}',
  });

  static const String _baseUrl = 'http://192.168.100.39:1990/suppliers';
}

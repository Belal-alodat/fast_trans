import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../core/app_session.dart';
import '../rest/customer_login_api.dart';
import '../util/exception_handler.dart';

class Auth with ChangeNotifier {
  bool _isAuth = false;

  get isAuth => AppSession.instance.isLogin;

  logout() {
    AppSession.instance.isLogin = false;

    notifyListeners();
  }

  Future<void> login(String username, String password) {
    print('login');
    //  AppSession.instance.credential = Credential(username, password);
    return _authenticate(username, password);
    //print('Utility '+Utility.getNoOnce());
  }

  static const SUCCESS_CODE = "0";

/*  Future<void> _authenticate() async {
    AppSession.instance.isLogin = true;
    notifyListeners();
  }*/
  Future<void> _authenticate(String username, String password) async {
    CustomerLoginApi customerLoginApi = CustomerLoginApi();
    LoginRequest customerLoginRequest;
    LoginResponse customerLoginResponse;
    try {
      String lang_code = AppSession.instance.languageCode;
      customerLoginRequest = LoginRequest(
          userName: username, password: password, lang_code: lang_code);

      customerLoginResponse =
          await customerLoginApi.login(customerLoginRequest);

      AppSession.instance.isLogin = true;

      // AppSession.instance.medicalCustomerId=customerLoginResponse.customer.medCustomerID;
      // AppSession.instance.idNumber =customerLoginResponse.customer.iqamahID;

      notifyListeners();
    } catch (e) {
      if (e is DioError) {
        print('type=${e.type}');
        print('handel' + handleResponse(e.response?.statusCode ?? 0));
      }

      print('sss=$e');
      String test = ExceptionHandler.handleException(e);
      print('error=$test');
    }
  }

  static String handleResponse(int statusCode) {
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return "Unauthorized request";
        break;
      case 404:
        return "Not found";
        break;
      case 409:
        return "Error due to a conflict";
        break;
      case 408:
        return "Connection request timeout";
        break;
      case 500:
        return "Internal Server Error";
        break;
      case 503:
        return "Service unavailable";
        break;
      default:
        var responseCode = statusCode;
        return "Received invalid status code: $responseCode";
    }
  }
}

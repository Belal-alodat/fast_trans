import 'dart:core';

import 'package:flutter/widgets.dart';

import '../core/app_session.dart';
import '../rest/customer_login_api.dart';
import '../rest/customer_register_api.dart';

class Auth with ChangeNotifier {
  bool _isAuth = false;

  get isAuth => AppSession.instance.isLogin;

  logout() {
    AppSession.instance.isLogin = false;
    AppSession.instance.token = "";
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

    String lang_code = AppSession.instance.languageCode;
    customerLoginRequest = LoginRequest(
        userName: username, password: password, lang_code: lang_code);

    customerLoginResponse = await customerLoginApi.login(customerLoginRequest);

    AppSession.instance.isLogin = true;
    AppSession.instance.token = customerLoginResponse.token;

    notifyListeners();
  }

  Future<void> register(
      {required String email,
      required String password,
      required String fullName,
      required String mobile}) async {
    RegisterApi registerApi = RegisterApi();
    RegisterRequest registerRequest = RegisterRequest(
      fullName: fullName,
      password: password,
      mobile: mobile,
      email: email,
    );
    await registerApi.register(registerRequest);
  }
}

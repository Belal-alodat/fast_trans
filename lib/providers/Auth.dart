import 'dart:core';

import 'package:flutter/widgets.dart';

import '../core/app_session.dart';
import '../rest/customer_login_api.dart';
import '../rest/customer_register_api.dart';
import '../rest/lookups_api.dart';

class Auth with ChangeNotifier {
  Auth() {}
  bool _isAuth = false;
  String _token = '';
  String get token => _token;
  get isAuth => _isAuth;

  logout() {
    AppSession.instance.isLogin = false;
    AppSession.instance.token = "";
    AppSession.instance.fromAddresses = [];
    AppSession.instance.toAddresses = [];
    AppSession.instance.packages = [];
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

    LookupAPI lookupAPI = LookupAPI();
    var addressLockupResponse = await lookupAPI.getAddressLookups();
    AppSession.instance.cities = addressLockupResponse.cities;
    AppSession.instance.citiesList= AppSession.instance.cities.keys.map((e) => e).toList();

    var dimensionsLookup = await lookupAPI.getDimensionsLookups();
    AppSession.instance.dimensions = dimensionsLookup.dimensions;
    AppSession.instance.dimensionList=  AppSession.instance.dimensions.keys.map((e) => e).toList();

    var productResponse = await lookupAPI.getProducts();
    AppSession.instance.products = productResponse.products;
    AppSession.instance.productList = productResponse.products.keys.map((e) => e).toList();
    //cities = await AppSession.instance.getcities();
    //citiesList = cities.keys.map((e) => e).toList();

    String lang_code = AppSession.instance.languageCode;
    customerLoginRequest = LoginRequest(
        userName: username, password: password, lang_code: lang_code);

    customerLoginResponse = await customerLoginApi.login(customerLoginRequest);

    AppSession.instance.isLogin = true;
    AppSession.instance.token = customerLoginResponse.token;
    _isAuth = true;
    _token = customerLoginResponse.token;

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

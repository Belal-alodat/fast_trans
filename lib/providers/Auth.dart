import 'dart:core';


import 'package:flutter/widgets.dart';

import '../models/address.dart';
import '../models/package.dart';
import '../rest/customer_login_api.dart';
import '../rest/customer_register_api.dart';
import '../rest/lookups_api.dart';

class Auth with ChangeNotifier {
  Auth() {}
  bool _isAuth = false;
  String _token = '';
  String role = '';
  String get token => _token;
  get isAuth => _isAuth;

  logout() {
    _isAuth = false;
    _token ="";
    role = '';
    //AppSession.instance.isLogin = false;
   // AppSession.instance.token = "";
    //AppSession.instance.fromAddresses = [];
   // AppSession.instance.toAddresses = [];
   // AppSession.instance.packages = [];
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

  //LookupAPI lookupAPI  = LookupAPI();

  Map<String, City> cities = {};
  List<String> citiesList = [];

  List<String> productList = [];
  List<String> dimensionList = [];
  Map<String, Dimension> dimensions = {};
  Map<String, Product> products ={};

  Future<void> _authenticate(String username, String password) async {
    CustomerLoginApi customerLoginApi = CustomerLoginApi();
    LoginRequest customerLoginRequest;
    LoginResponse customerLoginResponse;

    LookupAPI lookupAPI = LookupAPI();
    var addressLockupResponse = await lookupAPI.getAddressLookups();
     cities = addressLockupResponse.cities;
     citiesList= cities.keys.map((e) => e).toList();

    var dimensionsLookup = await lookupAPI.getDimensionsLookups();
    dimensions = dimensionsLookup.dimensions;
     dimensionList=   dimensions.keys.map((e) => e).toList();

    var productResponse = await lookupAPI.getProducts();
     products = productResponse.products;
     productList = productResponse.products.keys.map((e) => e).toList();
    //cities = await AppSession.instance.getcities();
    //citiesList = cities.keys.map((e) => e).toList();


    customerLoginRequest = LoginRequest(
        userName: username, password: password);

    customerLoginResponse = await customerLoginApi.login(customerLoginRequest);

   // AppSession.instance.isLogin = true;
    //AppSession.instance.token = customerLoginResponse.token;
    _isAuth = true;
    role = customerLoginResponse.role;
    _token = customerLoginResponse.token;

    notifyListeners();

  }

  Future<void> register(
      {required String email,
      required String password,
      required String fullName,
        required String role,
      required String mobile}) async {
    RegisterApi registerApi = RegisterApi();
    RegisterRequest registerRequest = RegisterRequest(
      fullName: fullName,
      password: password,
      mobile: mobile,
      email: email,
      role:role,
    );
    await registerApi.register(registerRequest);
  }
}

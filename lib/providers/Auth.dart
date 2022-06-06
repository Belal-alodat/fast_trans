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
  // enum ShipmentStatus{Customer_Submitted,Operator_Assigned_For_Picking  ,Driver_Picked,
  // Operator_Assigned_For_Delivery,Driver_Delivered
  // ,Customer_Canceled,Customer_Rejected,Customer_Accepted
  // ,Operator_Rejected,Operator_Accepted,Operator_Store_Rejected,Operator_Store_Accepted
  // ,Driver_pick_Accepted,Driver_pick_Rejected,Driver_Stored,Driver_deliver_Accepted,Driver_deliver_Rejected,}
    String getShipmentStatusLabel(int status){
   //  if(role.contains('ROLE_SUPPLIER') )
       switch (status) {
         case 0:
           return "Submitted";
         case 1:
           return "Operator_Assigned_For_Picking";
         case 2:
           return "Driver_Picked";
         case 3:
           return "Operator_Assigned_For_Delivery";
         case 4:
           return "Driver_Delivered";
         case 5:
           return "Customer_Canceled";
         case 6:
           return "Customer_Rejected";
         case 7:
           return "Customer_Accepted";
         case 8:
           return "Operator_Rejected";
         case 9:
           return "Operator_Accepted";
         case 10:
           return "Operator_Store_Rejected";
         case 11:
           return "Operator_Store_Accepted";
         case 12:
           return "Driver_pick_Accepted";
         case 13:
           return "Driver_pick_Rejected";
         case 14:
           return "Driver_Stored";
         case 15:
           return "Driver_deliver_Accepted";
         case 16:
           return "Driver_deliver_Rejected";


     }


         return '';
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

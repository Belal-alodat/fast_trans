import 'dart:math';

import 'package:fast_trans/rest/package_api.dart';
import 'package:flutter/widgets.dart';

import '../models/shipment_package.dart';
import '../models/user_credentails.dart';
import '../rest/address_api.dart';

class AppSession {
  AppSession._privateConstructor();
  List<Address> fromAddresses = [];
  List<Address> toAddresses = [];
  List<ShipmentPackage> packages = [];

  Map<String, City> getcities() {
    AddressResponse addressResponse = AddressResponse.fromJson(addressesAsJson);
    Map<String, City> cities = addressResponse.cities;

    return cities;
  }
  Map<String, Product> getProducts() {
    ProductResponse productResponse = ProductResponse.fromJson(productsAsJson);
    Map<String, Product> products = productResponse.products;
    return products;
  }
  Map<String, Dimension> getDimensions() {
    DimensionResponse productResponse = DimensionResponse.fromJson(dimensionsAsJson);
    Map<String, Dimension> dimensions = productResponse.dimensions;
    return dimensions;
  }
  Credential get credential => _credential;

  set credential(Credential credential) => _credential = credential;

  static final AppSession _instance = AppSession._privateConstructor();

  static AppSession get instance => _instance;
  bool prefRead = false;
  String _languageCode = 'en';
  bool _isLogin = false;
  String _token = '';
  String get token => _token;

  set token(String token) => _token = token;

  Credential _credential = Credential('', '');

  String get languageCode => _languageCode;

  set languageCode(String languageCode) => _languageCode = languageCode;

  bool get isLogin => _isLogin;

  set isLogin(bool login) => _isLogin = login;

  double _safeAreaTextScalingFactor = 0.0;

  double get safeAreaTextScalingFactor => _safeAreaTextScalingFactor;

  set safeAreaTextScalingFactor(double safeAreaTextScalingFactor) =>
      _safeAreaTextScalingFactor = safeAreaTextScalingFactor;

  double _safeFactorHorizontal = 0.0;

  double get safeFactorHorizontal => _safeFactorHorizontal;

  double _safeFactorVertical = 0.0;

  double get safeFactorVertical => _safeFactorVertical;

  bool _isInitScreenSizeDone = false;

  void initScreenSize(MediaQueryData mediaQueryData) {
    //if(_isInitScreenSizeDone ) return;

    _isInitScreenSizeDone = true;
    final _divisor = 100.0;

    final _screenWidth = mediaQueryData.size.width;
    final _factorHorizontal = _screenWidth / _divisor;

    final _screenHeight = mediaQueryData.size.height;
    final _factorVertical = _screenHeight / _divisor;

    final _textScalingFactor = min(_factorVertical, _factorHorizontal);

    final _safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    _safeFactorHorizontal = (_screenWidth - _safeAreaHorizontal) / _divisor;

    final _safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    _safeFactorVertical = (_screenHeight - _safeAreaVertical) / _divisor;

    _safeAreaTextScalingFactor =
        min(_safeFactorHorizontal, _safeFactorHorizontal);

    print('Screen Scaling Values:' + '_screenWidth: $_screenWidth');
    print('Screen Scaling Values:' + '_factorHorizontal: $_factorHorizontal ');

    print('Screen Scaling Values:' + '_screenHeight: $_screenHeight');
    print('Screen Scaling Values:' + '_factorVertical: $_factorVertical ');

    print('_textScalingFactor: $_textScalingFactor ');

    print('Screen Scaling Values:' +
        '_safeAreaHorizontal: $_safeAreaHorizontal ');
    print('Screen Scaling Values:' +
        '_safeFactorHorizontal: $_safeFactorHorizontal ');

    print('Screen Scaling Values:' + '_safeAreaVertical: $_safeAreaVertical ');
    print('Screen Scaling Values:' +
        '_safeFactorVertical: $_safeFactorVertical ');

    print('_safeAreaTextScalingFactor: $_safeAreaTextScalingFactor ');
  }
}

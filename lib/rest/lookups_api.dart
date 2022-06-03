import 'dart:io';

import 'package:dio/dio.dart';

import '../models/address.dart';
import '../services/dio_client.dart';
import 'auth_api_base.dart';
import 'package_api.dart';

class LookupAPI {
  final DioClient dioClient = DioClient(AuthAPI.baseUrl, Dio(), headers: {
    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'

  });

  //static const String _baseUrl = 'http://192.168.100.39:1990/lookups';
 // static const String _baseUrl = 'http://192.168.71.31:1990';

  Future<AddressLookupResponse> getAddressLookups() async {
    final response = await dioClient.get("/lookups/cities" );
    AddressLookupResponse addressLockupResponse = await AddressLookupResponse.fromJson(response);
    return addressLockupResponse;
  }

  Future<DimensionResponse> getDimensionsLookups() async {
    final response = await dioClient.get("/lookups/dimensions" );
    DimensionResponse dimensionResponse = await DimensionResponse.fromJson(response);
    return dimensionResponse;
  }

  Future<ProductResponse> getProducts() async {
    final response = await dioClient.get("/lookups/products" );
    ProductResponse productResponse = ProductResponse.fromJson(response);
   // Map<String, Product> products = productResponse.products;
    return productResponse;
  }
  Future<DimensionResponse> getDimensions() async{
    final response = await dioClient.get("/lookups/dimensions" );
    DimensionResponse dimensionResponse = DimensionResponse.fromJson(response);
    //Map<String, Dimension> dimensions = productResponse.dimensions;
    return dimensionResponse;
  }

}

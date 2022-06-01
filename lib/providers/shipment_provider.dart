import 'dart:core';

import 'package:flutter/widgets.dart';

import '../models/address.dart';
import '../models/package.dart';
import '../rest/address_api.dart';
import '../rest/package_api.dart';
import '../rest/shipment_api.dart';
import 'Auth.dart';



class ShipmentProvider with ChangeNotifier {

   final String token ;
    ShipmentApi? shipmentApi ;//= ShipmentApi(auth.token);
   AddressApi? addressApi;
   PackageAPI? packageAPI ;

   ShipmentProvider(this.token){
     shipmentApi = ShipmentApi(token);
     addressApi = AddressApi(token);
     packageAPI = PackageAPI(token);
   }
  Future<void> saveShipment(ShipmentRequest shipmentRequest) async {
 //   print('toAddress=${shipmentRequest.toJson()}');
    await shipmentApi!.addShipment(shipmentRequest);
    //notifyListeners();
  }

   List<Address> toAddresses = [];
   List<Address> fromAddresses = [];
   List<Package> packages = [];

   Future<void> saveAddress(Address request) async {
     await addressApi!.saveAddress(request);
   }
   Future<void> getToAddress() async {
     AddressResponse addressResponse =   await addressApi!.getToAddress();
     toAddresses = addressResponse.addresses;
   }

   Future<void> getFromAddress() async {
     AddressResponse addressResponse = await addressApi!.getFromAddress();
     fromAddresses = addressResponse.addresses;
   }

   Future<void> savePackage(Package request) async {
       await packageAPI!.savePackage(request);
   }

   Future<void> getPackages() async {
     PackageResponse addressResponse = await packageAPI!.getPackages();
     packages = addressResponse.packages;
   }

}

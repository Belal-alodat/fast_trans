import 'dart:core';

import 'package:flutter/widgets.dart';

import '../models/address.dart';
import '../models/package.dart';
import '../rest/address_api.dart';
import '../rest/package_api.dart';
import '../rest/shipment_api.dart';
import '../util/exception_handler.dart';
import 'Auth.dart';



class CustomerProvider with ChangeNotifier {

   final String token ;
    ShipmentApi? shipmentApi ;//= ShipmentApi(auth.token);
   AddressApi? addressApi;
   PackageAPI? packageAPI ;

   CustomerProvider(this.token){
     shipmentApi = ShipmentApi(token);
     addressApi = AddressApi(token);
     packageAPI = PackageAPI(token);
   }
  Future<void> saveShipment(Shipment shipmentRequest) async {
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


   Future<void> updateShipmentsStatus(int ShipmentId,ShipmentStatus status) async {
     return  await shipmentApi!.updateShipmentsStatus(ShipmentId,status,basepath: '/suppliers');
   }

   Future<List<Shipment>> getShipmentsWithStatus( ShipmentStatus status) async {
     try{
       return  await shipmentApi!.getShipmentsWithStatus(status,'/suppliers');
     } catch (error) {

       var errorMessage = ExceptionHandler.handleException(error);
       print("errorMessage= $errorMessage error=$error");
       if (errorMessage == ExceptionHandler.KUnAuthorized) {
         errorMessage = ExceptionHandler.kInvalidCredentials;
       }
       List<Shipment> empty = [];
       return empty;
       //Dialogs.showErrorDialog(errorMessage, context,() {Navigator.of(context).pop();},);
     }
     //notifyListeners();
   }

}

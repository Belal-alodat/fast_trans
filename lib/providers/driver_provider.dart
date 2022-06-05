import 'dart:core';

import 'package:flutter/widgets.dart';

import '../models/address.dart';
import '../models/package.dart';
import '../rest/address_api.dart';
import '../rest/driver_api.dart';
import '../rest/package_api.dart';
import '../rest/shipment_api.dart';
import '../util/exception_handler.dart';
import 'Auth.dart';



class DriverProvider with ChangeNotifier {

   final String token ;
    ShipmentApi? shipmentApi ;//= ShipmentApi(auth.token);
   AddressApi? addressApi;
   PackageAPI? packageAPI ;
   DriverApi? driverApi ;
   DriverProvider(this.token){
     shipmentApi = ShipmentApi(token);
     driverApi = DriverApi(token);
     packageAPI = PackageAPI(token);
   }

   Future<List<Driver>> getDrivers( ) async {
     return  await driverApi!.getDrivers();
     //notifyListeners();
   }

   Future<void> addPickupshipmentToDriver(int shipmentId,int driverId,ShipmentStatus shipmentStatus ) async {
     await driverApi!.addPickupshipmentToDriver(shipmentId,driverId,shipmentStatus);

     //notifyListeners();
   }

   Future<void> updateDriverShipmentsStatus(int ShipmentId,int status,ShipmentStatus toStatus) async {
     return  await shipmentApi!.updateDriverShipmentsStatus(ShipmentId,status,toStatus,basepath: '/drivers');
   }

   Future<List<Shipment>> getShipmentsWithStatus( List<ShipmentStatus> statusList) async {
     try{
       return  await shipmentApi!.getShipmentsWithStatus(statusList,'/drivers');
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

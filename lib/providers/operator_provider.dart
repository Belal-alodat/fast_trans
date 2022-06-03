import 'dart:core';

import 'package:flutter/widgets.dart';

import '../models/address.dart';
import '../models/package.dart';
import '../rest/address_api.dart';
import '../rest/driver_api.dart';
import '../rest/package_api.dart';
import '../rest/shipment_api.dart';
import 'Auth.dart';



class OperatorProvider with ChangeNotifier {

   final String token ;
    ShipmentApi? shipmentApi ;//= ShipmentApi(auth.token);
   AddressApi? addressApi;
   PackageAPI? packageAPI ;
   DriverApi? driverApi ;
   OperatorProvider(this.token){
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

   Future<List<Shipment>> getShipmentsWithStatus( ShipmentStatus status) async {
     return  await shipmentApi!.getShipmentsWithStatus(status);
     //notifyListeners();
   }
}

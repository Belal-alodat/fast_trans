import 'dart:core';

import 'package:flutter/widgets.dart';

import '../models/address.dart';
import '../models/package.dart';
import '../rest/address_api.dart';
import '../rest/package_api.dart';
import '../rest/shipment_api.dart';
import '../util/exception_handler.dart';
import 'Auth.dart';


class ShipmentsProvider with ChangeNotifier {

  final String token ;
  ShipmentApi? shipmentApi ;//= ShipmentApi(auth.token);
  AddressApi? addressApi;
  PackageAPI? packageAPI ;

  ShipmentsProvider(this.token){
    shipmentApi = ShipmentApi(token);
    addressApi = AddressApi(token);
    packageAPI = PackageAPI(token);
  }

  Future<List<Shipment>> getShipmentsWithStatus( List<ShipmentStatus> status,{String basepath = '/suppliers'}) async {
    try{
      return  await shipmentApi!.getShipmentsWithStatus(status,basepath);
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

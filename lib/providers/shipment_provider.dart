import 'dart:core';

import 'package:flutter/widgets.dart';

import '../rest/shipment_api.dart';
import 'Auth.dart';



class ShipmentProvider with ChangeNotifier {
   final Auth auth ;
   ShipmentProvider(this.auth);
  Future<void> saveShipment(ShipmentRequest shipmentRequest) async {
    print('toAddress=${shipmentRequest.toJson()}');
    await ShipmentApi(auth.token).addShipment(shipmentRequest);
    //notifyListeners();
  }


}

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fast_trans/rest/shipment_api.dart';
import '../models/package.dart';
import '../models/address.dart';
import '../services/dio_client.dart';
import 'auth_api_base.dart';
import 'operator_api_base.dart';
import 'supplier_api_base.dart';
main() async {
  DriverApi driverApi = DriverApi('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJVc2VyIERldGFpbHMiLCJpc3MiOiJZT1VSIEFQUExJQ0FUSU9OL1BST0pFQ1QvQ09NUEFOWSBOQU1FIiwiaWF0IjoxNjUyODU5NDE4LCJlbWFpbCI6InRAY29tIn0.GOkvwWjP5cZBN0Cswn-0zprEZhLIAec0I-zwbH6rVSs');
  List<Driver> drivers = await driverApi.getDrivers();

  for (Driver ship in drivers) {
    print('Driver=${ship.id}');
  }
}

class DriverApi extends OperatorAPI {

  DriverApi(String token): super(token);

  Future<List<Driver>> getDrivers( ) async {

    print('on getDrivers');
    final driversAsJson = await dioClient!.get("/operators/drivers");
       List<Driver> drivers= [];

    for (Map<String, dynamic> driverAsJson in driversAsJson) {
      drivers.add(Driver.fromJson(driverAsJson));
    }
    return drivers;
  }



  Future<void> addPickupshipmentToDriver(int shipmentId, int driverId,ShipmentStatus shipmentStatus) async{
    if(shipmentStatus == ShipmentStatus.Customer_Accepted) {

      await dioClient!.post(
          "/operators/drivers/$driverId/shipment/$shipmentId/status/${ShipmentStatus.Operator_Assigned_For_Picking.index}");
    }else{
      await dioClient!.post(
          "/operators/drivers/$driverId/shipment/$shipmentId/status/${ShipmentStatus.Operator_Assigned_For_Delivery.index}");
    }
  }
}
class Driver {
  final int id;
  final Account account;
  Driver({required this.id,required this.account});
  Driver.fromJson(Map<String, dynamic> jsonObject):this(
    id: jsonObject['id'] as int,
    account: Account.fromJson(jsonObject['account'] as Map<String, dynamic>),
  );
}

class Account{
  final String email;
  final String fullName;
  final String mobile;

  Account({required this.mobile,required this.fullName,required this.email});
  Account.fromJson(Map<String, dynamic> jsonObject):this(
    email: jsonObject['email'] as String,
    fullName: jsonObject['fullName'] as String,
    mobile: jsonObject['mobile'] as String,
);

}

import 'dart:io';
import 'package:dio/dio.dart';
import '../models/package.dart';
import '../models/address.dart';
import '../services/dio_client.dart';
import 'auth_api_base.dart';
import 'supplier_api_base.dart';

enum ShipmentStatus{Submitted,Assigned_For_Picking  ,Picked,Assigned_For_Delivery,Delivered  }

main() async {
  ShipmentApi shipmentApi = ShipmentApi('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJVc2VyIERldGFpbHMiLCJpc3MiOiJZT1VSIEFQUExJQ0FUSU9OL1BST0pFQ1QvQ09NUEFOWSBOQU1FIiwiaWF0IjoxNjUyODU5NDE4LCJlbWFpbCI6InRAY29tIn0.GOkvwWjP5cZBN0Cswn-0zprEZhLIAec0I-zwbH6rVSs');

  List<Shipment> ships =  await shipmentApi.getShipmentsWithStatus(ShipmentStatus.Assigned_For_Picking);
  for (Shipment ship in ships) {
    print('ship=${ship.id}');
  }
}

class ShipmentApi extends SupplierAPI {

  ShipmentApi(String token): super(token);


  Future<void> addShipment(Shipment request) async {
    print('on register');
    Map<String, dynamic> requestMap = request.toJson();

    final response = await dioClient!.post("/suppliers/shipments", data: requestMap);
  }

  /*Future<List<Shipment>> getSubmittedShipments( ) async {
    return await getShipmentsWithStatus( 1);
  }*/

  Future<List<Shipment>> getShipmentsWithStatus( ShipmentStatus status) async{
    print('on getShipmentWithStatus');
    final shipmentsAsJson = await dioClient!.get("/operators/shipments?status=${status.index}");
       List<Shipment> shipments= [];

    for (Map<String, dynamic> shipmentJson in shipmentsAsJson) {
      shipments.add(Shipment.fromJson(shipmentJson));
    }
    return shipments;
  }
}

class Shipment {

  final int id ;
  final Package shipmentPackage;
  final String pickupDate;
  final String pickupTime;
  final Address fromAddress;
  final Address toAddress;

  Shipment({
    this.id = -1,
    required this.shipmentPackage,
      this.pickupDate="2023-12-12",
      this.pickupTime="12:12:12" ,
    required this.fromAddress,
    required this.toAddress,
  });

  Shipment.fromJson(Map<String, dynamic> jsonObject):this(
      id:jsonObject['id'] as int,
      pickupDate:jsonObject['pickupDate'] as String ,
      pickupTime:jsonObject['pickupTime'] as String ,
      shipmentPackage: Package.fromJson(jsonObject['packageDetails'] as Map<String, dynamic>),
      toAddress: Address.fromJson(jsonObject['toAddress'] as Map<String, dynamic> ),
      fromAddress: Address.fromJson(jsonObject['fromAddress'] as Map<String, dynamic> ),
  ) ;
  Map<String, dynamic> toJson() {
   // print('on toJson $mobile');
    final Map<String, dynamic> jsonObject = new Map<String, dynamic>();
    //final Map<String, dynamic> jsonObject0 = new Map<String, dynamic>();

    jsonObject["packageDetails"] = shipmentPackage.toJson();
    jsonObject["toAddress"] = toAddress.toJson();
    jsonObject["fromAddress"] = fromAddress.toJson();
    jsonObject["pickupDate"] = pickupDate;
    jsonObject["pickupTime"] = pickupTime;
    return jsonObject;
  }
}

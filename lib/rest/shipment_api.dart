import 'dart:io';
import 'package:dio/dio.dart';
import '../models/package.dart';
import '../models/address.dart';
import '../services/dio_client.dart';
import 'auth_api_base.dart';
import 'supplier_api_base.dart';

enum ShipmentStatus{Customer_Submitted,Operator_Assigned_For_Picking  ,Driver_Picked,
  Operator_Assigned_For_Delivery,Driver_Delivered
  ,Customer_Canceled,Customer_Rejected,Customer_Accepted
  ,Operator_Rejected,Operator_Accepted,Operator_Store_Rejected,Operator_Store_Accepted
  ,Driver_pick_Accepted,Driver_pick_Rejected,Driver_Stored,Driver_deliver_Accepted,Driver_deliver_Rejected,}

main() async {
  ShipmentApi shipmentApi = ShipmentApi('eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkQGNvbSIsInJvbGVzIjoiUk9MRV9EUklWRVIiLCJpYXQiOjE2NTQ0MjI3OTIsImV4cCI6MTY1NDQ0MDc5Mn0.BmYoXHDxMGqqdHSBsU0JXW6cfL9p-bUzgouczfVe_DU');

  List<Shipment> ships =  await shipmentApi.getShipmentsWithStatus([ShipmentStatus.Driver_pick_Accepted,ShipmentStatus.Driver_Picked,ShipmentStatus.Driver_deliver_Accepted],'/drivers');
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


  Future<void> updateDriverShipmentsStatus(int ShipmentId,int status,ShipmentStatus toStatus,{String basepath ='/suppliers'}) async {
    print('on updateDriverShipmentsStatus');

    String uri ='$basepath/shipments/$ShipmentId/status/${status}/to/${toStatus.index}';

    final response = await dioClient!.patch(uri);
  }

  Future<void> updateShipmentsStatus(int ShipmentId,ShipmentStatus status,{String basepath ='/suppliers'}) async {
    print('on updateShipmentsStatus');

    String uri ='$basepath/shipments/$ShipmentId/status/${status.index}';

    final response = await dioClient!.patch(uri);
  }

  /*Future<List<Shipment>> getSubmittedShipments( ) async {
    return await getShipmentsWithStatus( 1);
  }*/


  Future<List<Shipment>> getShipmentsWithStatus( List<ShipmentStatus> statusList,String basepath) async{
    String stattusStr = '';
    if(statusList.length > 1) {
      for (ShipmentStatus status in statusList) {
        stattusStr += '${status.index},';
      }
    }else{
      stattusStr += '${statusList[0].index}';
    }
    final shipmentsAsJson = await dioClient!.get("$basepath/shipments?status=${stattusStr}");
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
  final int status;

  Shipment({
    this.id = -1,
    required this.shipmentPackage,
      this.pickupDate="2023-12-12",
      this.pickupTime="12:00:00" ,
    required this.fromAddress,
    required this.toAddress,
    required this.status,
  });

  Shipment.fromJson(Map<String, dynamic> jsonObject):this(
      id:jsonObject['id'] as int,
      status: jsonObject['status'] as int,
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
    jsonObject["status"] = status;
    jsonObject["id"] = id;
    jsonObject["packageDetails"] = shipmentPackage.toJson();
    jsonObject["toAddress"] = toAddress.toJson();
    jsonObject["fromAddress"] = fromAddress.toJson();
    jsonObject["pickupDate"] = pickupDate;
    jsonObject["pickupTime"] = pickupTime;
    return jsonObject;
  }
}

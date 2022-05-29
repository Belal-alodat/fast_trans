import '../models/package.dart';
import '../models/address.dart';
import 'supplier_api_base.dart';

class ShipmentApi extends SupplierAPI {

  ShipmentApi(String token): super(token);


  Future<void> addShipment(ShipmentRequest request) async {
    print('on register');
    Map<String, dynamic> requestMap = request.toJson();

    final response = await dioClient!.post("/shipments", data: requestMap);
  }
}

class ShipmentRequest {

  final Package shipmentPackage;
  final String pickupDate;
  final String pickupTime;
  final Address fromAddress;
  final Address toAddress;

  ShipmentRequest({
    required this.shipmentPackage,
      this.pickupDate="2023-12-12",
      this.pickupTime="12:12:12" ,
    required this.fromAddress,
    required this.toAddress,
  });

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

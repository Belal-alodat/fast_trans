import 'supplier_api_base.dart';
import '../models/address.dart';
class AddressApi extends SupplierAPI {

  AddressApi(String token): super(token);

  Future<void> saveAddress(Address request) async {
    Map<String, dynamic> requestMap = request.toJson();
    await dioClient!.post("/suppliers/addresses", data: requestMap);
    print('response here');
  }

  Future<AddressResponse> getToAddress() async {
    final response = await dioClient!.get("/suppliers/addresses");
    AddressResponse addressResponse = await AddressResponse.fromJson(response);
    return addressResponse;
  }
  Future<AddressResponse> getFromAddress() async {
    final response = await dioClient!.get("/suppliers/addresses",queryParameters:{"type":"from"} );
    AddressResponse addressResponse = await AddressResponse.fromJson(response);
    return addressResponse;
  }


}
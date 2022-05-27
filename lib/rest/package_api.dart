import '../models/shipment_package.dart';
import 'supplier_api_base.dart';

class PackageAPI extends SupplierAPI {
  /*Future<LoginResponse> login(LoginRequest request) async {
    //  print('on login');
    Map<String, dynamic> requestMap = request.toJson();

    final response = await dioClient.post("/auth/login", data: requestMap);
    // print('response here');
    LoginResponse loginResponse = LoginResponse.fromJson(response);
    //  print('loginResponse${loginResponse.token}');
    return loginResponse;
  }

  private long id;
	@OneToOne
	private Product product;
	@OneToOne
	private Dimension dimension;
	private double price;
	private double weight;
	private int pieces;
  */
}

class ProductResponse {
  Map<String, Product> products = {};

  ProductResponse(this.products);

  List<String> getKeyListFromMap(){
    return products.keys.map((e) => e).toList();
  }

  ProductResponse.fromJson(List<Map<String, dynamic>> json) {
    for (Map<String, dynamic> product in json) {
      String productName = product['name'];
      print('productName=$productName');
      products[productName] = Product.fromJson(product);
    }
  }


}

class DimensionResponse {
  Map<String, Dimension> dimensions = {};

  DimensionResponse(this.dimensions);

  List<String> getKeyListFromMap(){
    return dimensions.keys.map((e) => e).toList();
  }

  DimensionResponse.fromJson(List<Map<String, dynamic>> json) {
    for (Map<String, dynamic> dimension in json) {
      String dimensionName = dimension['name'];
        print('dimensionName=$dimensionName');
      dimensions[dimensionName] = Dimension.fromJson(dimension);
    }
  }


}

main() {
  print('hi');
  ProductResponse s = ProductResponse.fromJson(productsAsJson);

  print('s=${s.products.length}');
  s.products.forEach((key, product) {
    print('product=${product.name}');
  });
}

List<Map<String, dynamic>> productsAsJson = [
  {
    "id": 1,
    "name": "product1",
    "description":"product description"
  },
  {
    "id": 2,
    "name": "product2",
    "description":"product2 description"
  },
];

List<Map<String, dynamic>> dimensionsAsJson = [
  {
    "id": 1,
    "name": "Dimension1",
    "description":"Dimension1 description"
  },
  {
    "id": 2,
    "name": "Dimension2",
    "description":"Dimension2 description"
  },
];
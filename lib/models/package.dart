
class PackageResponse {
  List<Package> packages = [];

  PackageResponse(this.packages);

  PackageResponse.fromJson(List<dynamic> json) {

    for ( dynamic package in json) {
      // int id = address['id'];
      packages.add(Package.fromJson(package));

    }
  }
}
class Package {
    Product? product;
    Dimension? dimension;
   bool  favourite;
    int? id;
    double? price;
    double? weight;
    int? pieces;
  Package({
    this.favourite=false,
    required this.id,
    required this.product,
    required this.dimension,
    required this.price,
    required this.weight,
    required this.pieces,
  });


  Package.fromJson(Map<String, dynamic> jsonObject, {this.favourite=true,}) {

    try {
      id = int.parse(jsonObject["id"]);
    }catch(_){

   //   print(jsonObject["id"]);

    }
    try {
    price =   jsonObject["price"]   as double;
  }catch(e){

    }
    try { weight =  jsonObject["weight"]  as double;
  }catch(_){}
    try {  pieces =  jsonObject["pieces"] as int;
}catch(_){}
     product = Product.fromJson(jsonObject["product"] ) ;
     dimension = Dimension.fromJson(jsonObject["dimension"] ) ;

  }

  Map<String, dynamic> toJson() {
    // print('on toJson $mobile');
    final Map<String, dynamic> jsonObject = new Map<String, dynamic>();


    jsonObject["id"] = id;

    jsonObject["product"] = product?.toJson();
    jsonObject["dimension"] = dimension?.toJson();

    jsonObject["price"] = price;
    jsonObject["weight"] = weight;
    jsonObject["pieces"] = pieces;
    return jsonObject;
  }

}

class Product {
    String name ='';
    int id=-1;
    String description ='';

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> jsonObject = new Map<String, dynamic>();
      jsonObject["name"] = name;
      jsonObject["id"] = id;
      return jsonObject;
    }

  Product.fromJson(Map<String, dynamic> json) {
    try {
      id = int.parse(json['id']);
    }catch(e){
    }
    // print('id=$id');
    name = json['name'];
    description = json['description'];

  }
}

class Dimension {
  String name ='';
  int id=-1;
  String description ='';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObject = new Map<String, dynamic>();
    jsonObject["name"] = name;
    jsonObject["id"] = id;
    return jsonObject;
  }

  Dimension.fromJson(Map<String, dynamic> json) {
    try {
      id = int.parse(json['id']);
    }catch(e){
    }
    // print('id=$id');
    name = json['name'];
    description = json['description'];

  }
}

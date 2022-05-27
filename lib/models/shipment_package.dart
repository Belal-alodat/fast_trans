class ShipmentPackage {
  final Product product;
  final Dimension dimension;

  final int id;
  final double price;
  final double weight;
  final int pieces;
  ShipmentPackage({
    required this.id,
    required this.product,
    required this.dimension,
    required this.price,
    required this.weight,
    required this.pieces,
  });

  Map<String, dynamic> toJson() {
    // print('on toJson $mobile');
    final Map<String, dynamic> jsonObject = new Map<String, dynamic>();


    jsonObject["id"] = id;

    jsonObject["productName"] = product.toJson();
    jsonObject["dimension"] = dimension.toJson();

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

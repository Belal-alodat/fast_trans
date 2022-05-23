class ShipmentPackage {
  final Product product;
  final Dimension dimension;
  final int id;
  final int price;
  final int weight;
  final int pieces;
  ShipmentPackage({
    required this.id,
    required this.product,
    required this.dimension,
    required this.price,
    required this.weight,
    required this.pieces,
  });
}

class Product {
  final String name;
  final String description;
  Product({required this.name, required this.description});
}

class Dimension {
  final String name;
  final String description;
  Dimension({required this.name, required this.description});
}

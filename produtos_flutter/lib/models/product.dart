class Product {
  final int id;
  final String title;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  Product.fromJson(Map<String, dynamic> map)
    : id = map['id'],
      title = map['title'],
      price = map['price'],
      imageUrl = map['imageUrl'];

  static List<Product> fromJsonList(List<dynamic> json) {
    return json.map((entity) => Product.fromJson(entity)).toList();
  }
}

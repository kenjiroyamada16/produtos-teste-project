import 'pagy.dart';
import 'product.dart';

class ProductsList {
  final Pagy pagy;
  final List<Product> products;

  ProductsList({required this.pagy, required this.products});

  factory ProductsList.fromJson(Map<String, dynamic> map) {
    return ProductsList(
      products: Product.fromJsonList(map['data']),
      pagy: Pagy.fromJson(map['pagy']),
    );
  }
}

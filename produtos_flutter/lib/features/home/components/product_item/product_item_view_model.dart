import '../../../../models/product.dart';
import '../../../../support/utils/extensions/number_extensions.dart';
import 'product_item_view.dart';

class ProductItemViewModel extends ProductItemViewModelProtocol {
  final Product product;

  ProductItemViewModel({required this.product});

  @override
  String get imageUrl => product.imageUrl;

  @override
  String get price => product.price.toBRL;

  @override
  String get title => product.title;
}

import 'package:flutter/material.dart'
    show ScrollController, TextEditingController;

import '../../data/domain/models/api_response.dart';
import '../../data/domain/repositories/products_repository.dart';
import '../../models/pagy.dart';
import '../../models/product.dart';
import '../../support/utils/debouncer.dart';
import '../../support/utils/extensions/exception_extensions.dart';
import 'components/product_item/product_item_view.dart';
import 'components/product_item/product_item_view_model.dart';
import 'home_view.dart';

class HomeViewModel extends HomeViewModelProtocol {
  bool _isLoading = false;
  String _searchQuery = '';
  String _errorMessage = '';
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchTextController = TextEditingController();

  Pagy _pagy = Pagy.initial();
  final List<Product> _productsList = List.empty(growable: true);

  final ProductsRepositoryProtocol productsRepository;

  HomeViewModel({required this.productsRepository});

  @override
  bool get isLoading => _productsList.isEmpty && _isLoading;

  @override
  String get errorMessage => _errorMessage;

  @override
  ScrollController get scrollController => _scrollController;

  @override
  int get currentPage => _pagy.currentPage;

  @override
  int get totalPages => _pagy.totalPages;

  @override
  TextEditingController get searchTextController => _searchTextController;

  @override
  List<ProductItemViewModelProtocol> get productItemViewModels {
    return _productsList.map((product) {
      return ProductItemViewModel(product: product);
    }).toList();
  }

  @override
  Future<void> getProductsList(int page) async {
    await _getProductsList(page);
  }

  @override
  void didSearchProduct(String text) {
    final debouncer = Debouncer();

    debouncer.run(() {
      _searchQuery = text;
      _resetProductsList();
    });
  }

  @override
  void didTapClearSearch() {
    _searchQuery = '';
    _searchTextController.text = '';
    _resetProductsList();
  }

  Future<void> _getProductsList(int page) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    final response = await productsRepository.getProducts(
      page: page,
      query: _searchQuery,
    );

    switch (response) {
      case Success():
        _errorMessage = '';

        _productsList.addAll(response.value.products);
        _pagy = response.value.pagy;
      case Failure():
        _errorMessage = response.error.message;
    }

    _isLoading = false;
    notifyListeners();
  }

  void _resetProductsList() {
    _productsList.clear();
    _pagy = Pagy.initial();
    _getProductsList(_pagy.currentPage);
  }
}

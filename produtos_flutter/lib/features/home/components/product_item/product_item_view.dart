import 'package:flutter/material.dart';

abstract class ProductItemViewModelProtocol {
  String get title;
  String get price;
  String get imageUrl;
}

class ProductItemView extends StatelessWidget {
  final ProductItemViewModelProtocol viewModel;

  const ProductItemView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox.square(
            dimension: 80,
            child: Image.network(
              viewModel.imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(Icons.warning, size: 40),
                  ),
                );
              },
              loadingBuilder: (_, child, loadingProgress) {
                if (loadingProgress == null) return child;

                return Center(
                  child: SizedBox.square(
                    dimension: 24,
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Column(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(viewModel.title, style: TextStyle(fontSize: 16)),
                Text(
                  viewModel.price,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

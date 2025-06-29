import 'package:flutter/material.dart';

import '../../support/components/paginated_list.dart';
import '../../support/utils/injector.dart';
import 'components/product_item/product_item_view.dart';

abstract class HomeViewModelProtocol with ChangeNotifier {
  int get totalPages;
  int get currentPage;
  bool get isLoading;
  String get errorMessage;
  TextEditingController get searchTextController;
  List<ProductItemViewModelProtocol> get productItemViewModels;

  ScrollController get scrollController;

  void getProductsList(int page);
  void didTapClearSearch();
  void didSearchProduct(String text);
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final viewModel = injector.get<HomeViewModelProtocol>();

  @override
  void initState() {
    super.initState();
    viewModel.getProductsList(viewModel.currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (_, __) {
              return CustomScrollView(
                controller: viewModel.scrollController,
                slivers: [
                  SliverAppBar(
                    collapsedHeight: 100,
                    expandedHeight: 180,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text('Produtos'),
                      centerTitle: true,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: TextFormField(
                        onChanged: viewModel.didSearchProduct,
                        controller: viewModel.searchTextController,
                        decoration: InputDecoration(
                          hintText: 'Pesquise por um produto!',
                          suffixIcon: IconButton(
                            onPressed: viewModel.didTapClearSearch,
                            icon: Icon(Icons.cancel_outlined),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  _bodyWidget,
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget get _bodyWidget {
    if (viewModel.errorMessage.isNotEmpty) {
      return SliverFillRemaining(
        child: Center(child: Text(viewModel.errorMessage)),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      sliver: PaginatedList(
        scrollController: viewModel.scrollController,
        itemCount: viewModel.productItemViewModels.length,
        totalPages: viewModel.totalPages,
        isLoading: viewModel.isLoading,
        currentPage: viewModel.currentPage,
        isEmpty: viewModel.productItemViewModels.isEmpty,
        emptyMessage: 'Nenhum produto encontrado',
        itemBuilder: (_, index) {
          return ProductItemView(
            viewModel: viewModel.productItemViewModels[index],
          );
        },
        onPageChanged: viewModel.getProductsList,
      ),
    );
  }
}

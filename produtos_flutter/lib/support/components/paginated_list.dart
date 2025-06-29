import 'package:flutter/material.dart';

class PaginatedList extends StatefulWidget {
  final int itemCount;
  final int totalPages;
  final int currentPage;
  final bool isLoading;
  final bool isEmpty;
  final String emptyMessage;
  final ScrollController scrollController;
  final ValueChanged<int> onPageChanged;
  final Widget? Function(BuildContext, int) itemBuilder;

  const PaginatedList({
    required this.itemCount,
    required this.totalPages,
    required this.isLoading,
    required this.isEmpty,
    required this.currentPage,
    required this.itemBuilder,
    required this.onPageChanged,
    required this.scrollController,
    required this.emptyMessage,
    super.key,
  });

  @override
  State<PaginatedList> createState() => _PaginatedListState();
}

class _PaginatedListState extends State<PaginatedList> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_setRequestPageListener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading && widget.itemCount == 0) {
      return SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SliverMainAxisGroup(
      slivers: [
        _getPaginatedList,
        SliverVisibility(
          visible: widget.isLoading,
          sliver: SliverToBoxAdapter(
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget get _getPaginatedList {
    if (widget.isEmpty) {
      return SliverFillRemaining(
        child: Center(child: Text(widget.emptyMessage)),
      );
    }
    return SliverList.builder(
      itemBuilder: widget.itemBuilder,
      itemCount: widget.itemCount,
    );
  }

  void _setRequestPageListener() {
    final isFinalList =
        widget.scrollController.position.pixels >=
        getNextPageLoadPositionTrigger;
    final isNotLastPage = widget.currentPage != widget.totalPages;
    final canSendRequest = isFinalList && !widget.isLoading && isNotLastPage;
    final nextPage = widget.currentPage + 1;
    if (canSendRequest) {
      widget.onPageChanged.call(nextPage);
    }
  }

  double get getNextPageLoadPositionTrigger {
    return widget.scrollController.position.maxScrollExtent *
        _nextPageTriggerPosition;
  }

  double get _nextPageTriggerPosition {
    const scrollFractionTrigger = 0.8;
    final scrollableAreaFraction = 1 / widget.currentPage;
    final pagesAlreadyScrolled = widget.currentPage - 1;

    final alreadyScrolledFraction =
        pagesAlreadyScrolled * scrollableAreaFraction;
    final newScrollableArea = scrollFractionTrigger * scrollableAreaFraction;

    return alreadyScrolledFraction + newScrollableArea;
  }
}

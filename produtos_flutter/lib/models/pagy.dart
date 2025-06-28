class Pagy {
  final int totalItems;
  final int totalPages;
  final int currentPage;
  final int pageSize;

  Pagy({
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
  });

  factory Pagy.fromJson(Map<String, dynamic> map) {
    return Pagy(
      totalItems: map['totalItems'],
      totalPages: map['totalPages'],
      currentPage: map['currentPage'],
      pageSize: map['pageSize'],
    );
  }
}

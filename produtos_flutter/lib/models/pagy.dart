class Pagy {
  int totalItems;
  int totalPages;
  int currentPage;
  int pageSize;

  Pagy({
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
  });

  factory Pagy.initial() {
    return Pagy(totalItems: 0, totalPages: 1, currentPage: 1, pageSize: 0);
  }

  factory Pagy.fromJson(Map<String, dynamic> map) {
    return Pagy(
      totalItems: map['totalItems'],
      totalPages: map['totalPages'],
      currentPage: map['currentPage'],
      pageSize: map['pageSize'],
    );
  }
}

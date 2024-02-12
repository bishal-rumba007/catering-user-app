

class SearchMenuModel{
  final String title;
  final String caterer;
  final String menuId;
  final String imageUrl;

  SearchMenuModel({
    required this.title,
    required this.caterer,
    required this.menuId,
    required this.imageUrl,
  });

  factory SearchMenuModel.fromJson(Map<String, dynamic> json) {
    return SearchMenuModel(
      title: json['categoryName'],
      caterer: json['providerName'],
      menuId: json['menuId'],
      imageUrl: json['imageUrl'],
    );
  }
}


class Menus {
  String userId;
  String menuId;
  String providerName;
  double price;
  String categoryId;
  String categoryName;
  String categoryImage;
  List<String> starterMenu;
  List<String> mainCourseMenu;
  List<String> dessertMenu;

  Menus({
    required this.userId,
    required this.menuId,
    required this.providerName,
    required this.price,
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.starterMenu,
    required this.mainCourseMenu,
    required this.dessertMenu,
  });

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      userId: json['userId'],
      menuId: json['menuId'],
      providerName: json['providerName'],
      price: double.tryParse(json['price'] ?? '') ?? 0.0,
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      categoryImage: json['categoryImage'],
      starterMenu: List<String>.from(json['starterMenu']),
      mainCourseMenu: List<String>.from(json['mainCourseMenu']),
      dessertMenu: List<String>.from(json['dessertMenu']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'providerName': providerName,
      'price': price,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'starterMenu': starterMenu,
      'mainCourseMenu': mainCourseMenu,
      'dessertMenu': dessertMenu,
    };
  }
}

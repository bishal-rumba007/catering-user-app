import 'package:catering_user_app/src/features/review/domain/review_model.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class Menus {
  String userId;
  String menuId;
  String providerName;
  double price;
  String categoryId;
  String categoryName;
  String categoryImage;
  String menuDescription;
  List<String> starterMenu;
  List<String> mainCourseMenu;
  List<String> dessertMenu;
  final types.User user;
  List<ReviewModel>? reviews;

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
    required this.menuDescription,
    required this.user,
    this.reviews = const [],
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
      menuDescription: json['menuDescription'],
      starterMenu: List<String>.from(json['starterMenu']),
      mainCourseMenu: List<String>.from(json['mainCourseMenu']),
      dessertMenu: List<String>.from(json['dessertMenu']),
      user: json['user'],
      reviews: json['reviews'],
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

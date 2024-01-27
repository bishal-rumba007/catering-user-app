class CategoryModel {
  String categoryId;
  String categoryTitle;
  String categoryImage;

  CategoryModel({
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryImage,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'],
      categoryTitle: json['categoryTitle'],
      categoryImage: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryTitle'] = categoryTitle;
    data['imageUrl'] = categoryImage;
    return data;
  }
}

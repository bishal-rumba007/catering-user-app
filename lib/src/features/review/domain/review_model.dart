



class ReviewModel{
  String? reviewId;
  String review;
  double rating;
  String userId;
  String catererId;
  String orderId;
  String menuId;
  String createdAt;
  String userName;

  ReviewModel({
    this.reviewId,
    required this.review,
    required this.rating,
    required this.userId,
    required this.catererId,
    required this.orderId,
    required this.menuId,
    required this.createdAt,
    required this.userName,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewId: json['reviewId'],
      review: json['review'],
      rating: json['rating'],
      userId: json['userId'],
      catererId: json['catererId'],
      orderId: json['orderId'],
      menuId: json['menuId'],
      createdAt: json['createdAt'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'review': review,
      'rating': rating,
      'userId': userId,
      'catererId': catererId,
      'orderId': orderId,
      'menuId': menuId,
      'createdAt': createdAt,
      'userName': userName,
    };
  }

}
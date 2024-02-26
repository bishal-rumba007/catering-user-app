class PaymentDetailModel{
  String idx;
  String token;
  String orderId;
  String customerId;
  String catererId;
  String amount;
  String createdAt;
  OrderInfo orderInfo;

  PaymentDetailModel({
    required this.idx,
    required this.token,
    required this.orderId,
    required this.customerId,
    required this.catererId,
    required this.amount,
    required this.createdAt,
    required this.orderInfo,
  });

  factory PaymentDetailModel.fromJson(Map<String, dynamic> json) {
    return PaymentDetailModel(
      idx: json['idx'] as String,
      token: json['token'] as String,
      orderId: json['orderId'] as String,
      customerId: json['customerId'] as String,
      catererId: json['catererId'] as String,
      amount: json['amount'] as String,
      createdAt: json['createdAt'] as String,
      orderInfo: OrderInfo.fromJson(json['orderInfo']),
    );
  }

}

class OrderInfo{
  String price;
  String categoryImage;
  String menuName;
  String menuId;
  String contact;
  String customerName;
  String customerAddress;

  OrderInfo({
    required this.price,
    required this.categoryImage,
    required this.menuName,
    required this.menuId,
    required this.contact,
    required this.customerName,
    required this.customerAddress,
  });

  factory OrderInfo.fromJson(Map<String, dynamic> json) {
    return OrderInfo(
      price: json['price'] as String,
      categoryImage: json['categoryImage'] as String,
      menuName: json['menuName'] as String,
      menuId: json['menuId'] as String,
      contact: json['contact'] as String,
      customerName: json['customerName'] as String,
      customerAddress: json['customerAddress'] as String,
    );
  }
}
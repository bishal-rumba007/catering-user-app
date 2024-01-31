

import 'package:catering_user_app/src/features/order/data/order_datasource.dart';
import 'package:catering_user_app/src/features/order/domain/order_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProvider = StreamProvider<List<OrderModel>>((ref) => OrderDataSource().getOrdersStream());

final orderDetailProvider = StreamProvider.family<OrderModel, String>((ref, String id) => OrderDataSource().getOrderDetail(id));

final cancelOrderProvider = FutureProvider.family<String, String>(
        (ref, String orderId) => OrderDataSource().cancelOrder(orderId: orderId)
);












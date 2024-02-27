

import 'package:catering_user_app/src/features/order/data/order_datasource.dart';
import 'package:catering_user_app/src/features/order/domain/order_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

final orderProvider = StreamProvider<List<OrderModel>>((ref) => OrderDataSource().getOrdersStream());

final orderDetailProvider = StreamProvider.family<OrderModel, String>((ref, String id) => OrderDataSource().getOrderDetail(id));

final cancelOrderProvider = FutureProvider.family<String, String>(
        (ref, String orderId) => OrderDataSource().cancelOrder(orderId: orderId)
);

final bookedDateProvider = FutureProvider.family<List<DateTime>, String>(
        (ref, String catererId) => OrderDataSource().getAcceptedOrderDates(catererId)
);

final userDetailProvider = FutureProvider.family<types.User, String>(
        (ref, String userId) => OrderDataSource().getUserDetail(userId)
);










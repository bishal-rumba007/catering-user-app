



import 'package:catering_user_app/src/features/payment/data/payment_datasource.dart';
import 'package:catering_user_app/src/features/payment/domain/payment_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentHistoryProvider = FutureProvider.autoDispose<List<PaymentDetailModel>>((ref) => PaymentDataSource().getPaymentHistory());
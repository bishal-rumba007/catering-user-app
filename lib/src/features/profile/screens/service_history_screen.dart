
import 'package:catering_user_app/src/features/order/data/order_provider.dart';
import 'package:catering_user_app/src/features/order/domain/order_model.dart';
import 'package:catering_user_app/src/features/order/screens/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ServiceHistoryScreen extends ConsumerStatefulWidget {
  const ServiceHistoryScreen({super.key});

  @override
  ConsumerState<ServiceHistoryScreen> createState() => _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends ConsumerState<ServiceHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final serviceData = ref.watch(orderProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service History'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w,),
        child: serviceData.when(
          data: (data) {
            List<OrderModel> serviceHistory = data.where((element) => element.orderStatus.index == 3).toList();
            if (serviceHistory.isEmpty) {
              return const Center(child: Text('No Service History'));
            }
            return ListView.builder(
              itemCount: serviceHistory.length,
              itemBuilder: (context, index) {
                final order = serviceHistory[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( DateFormat('dd MMM yyyy').format(
                    DateTime.parse(order.orderDetail.orderDate)), style: Theme.of(context).textTheme.titleSmall,),
                    SizedBox(height: 5.h,),
                    OrderCard(order: order)
                  ],
                );
              },
            );
          },
          error: (error, stack) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
    );
  }
}


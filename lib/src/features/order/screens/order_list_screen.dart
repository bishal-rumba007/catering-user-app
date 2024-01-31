import 'dart:convert';

import 'package:catering_user_app/src/features/order/data/order_provider.dart';
import 'package:catering_user_app/src/features/order/screens/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class OrderListScreen extends ConsumerWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderData = ref.watch(orderProvider);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Orders'),
        ),
        body: orderData.when(
          data: (data) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: ListView.separated(
                padding: EdgeInsets.only(top: 14.h),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return OrderCard(order: data[index],);
                },
                separatorBuilder: (context, index) => SizedBox(height: 14.h,),
              ),
            );
          },
          error: (error, stackTrace) => Center(child: Text('$error'),),
          loading: () => const Center(child: CircularProgressIndicator(),),
        )
    );
  }
}
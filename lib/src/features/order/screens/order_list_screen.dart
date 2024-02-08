import 'package:catering_user_app/src/features/order/data/order_provider.dart';
import 'package:catering_user_app/src/features/order/domain/order_model.dart';
import 'package:catering_user_app/src/features/order/screens/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class OrderListScreen extends ConsumerStatefulWidget {
  const OrderListScreen({super.key});

  @override
  ConsumerState<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends ConsumerState<OrderListScreen> {
  @override
  Widget build(BuildContext context) {
    final orderData = ref.watch(orderProvider);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Orders'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),

        body: orderData.when(
          data: (data) {
            final orderList = data.where((element) {
              return element.orderStatus != OrderStatus.cancelled && element.orderStatus != OrderStatus.rejected;
            }).toList();
            return orderList.isEmpty ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No Orders Yet', style: Theme.of(context).textTheme.titleSmall,),
                  SizedBox(height: 10.h,),
                  Text('You have not placed any orders yet', style: Theme.of(context).textTheme.bodyLarge,),
                ],
              ),
            ) : Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: ListView.separated(
                padding: EdgeInsets.only(top: 14.h),
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  return OrderCard(order: orderList[index],);
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
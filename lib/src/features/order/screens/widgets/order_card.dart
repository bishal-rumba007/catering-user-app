import 'package:catering_user_app/src/features/order/screens/order_detail_screen.dart';
import 'package:catering_user_app/src/features/order/screens/widgets/common_function.dart';
import 'package:catering_user_app/src/features/order/domain/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class OrderCard extends StatefulWidget {
  final OrderModel order;
  const OrderCard({
    super.key, required this.order,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalPrice = double.parse(widget.order.price) * double.parse(widget.order.orderDetail.totalGuests);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OrderDetailScreen(orderId: widget.order.orderId),
            ),
        );
      },
      child: Card(
        elevation: 0,
        child: Container(
          padding: EdgeInsets.all(10.h),
          height: 150.h,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 114.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.order.categoryImage)
                  )
                ),
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.order.menuName} Order',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      height: 26.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Rs. ${double.parse(widget.order.price)}/person',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.people),
                          SizedBox(width: 6.w,),
                          Text(
                            widget.order.orderDetail.totalGuests,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.order.orderDetail.dietaryPref,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      height: 30.h,
                      width: 132.w,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: Text(
                          'Total ${formatTotalPrice(totalPrice)} Rs.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
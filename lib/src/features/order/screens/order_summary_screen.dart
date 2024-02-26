import 'package:catering_user_app/src/common/common_export.dart';
import 'package:catering_user_app/src/common/widgets/build_dialogs.dart';
import 'package:catering_user_app/src/features/chat/data/chat_datasource.dart';
import 'package:catering_user_app/src/features/order/data/order_datasource.dart';
import 'package:catering_user_app/src/features/order/domain/order_model.dart';
import 'package:catering_user_app/src/features/order/domain/pre_order_model.dart';
import 'package:catering_user_app/src/themes/export_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class OrderSummaryScreen extends StatefulWidget {
  final PreOrderModel preOrderModel;
  const OrderSummaryScreen({super.key, required this.preOrderModel});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  final _menuController = TextEditingController();
  final _guestController = TextEditingController();
  final _priceController = TextEditingController();
  String selectedTime = '01:45 PM';

  late int totalGuest;
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    _menuController.text = widget.preOrderModel.menu.categoryName;
    totalGuest = int.parse(widget.preOrderModel.totalGuests);
    _guestController.text = totalGuest.toString();
    totalPrice = widget.preOrderModel.menu.price * totalGuest;
    _priceController.text = totalPrice.toString();
  }

  void _increaseGuests() {
    setState(() {
      totalGuest += 5;
      _guestController.text = totalGuest.toString();
      totalPrice = widget.preOrderModel.menu.price * totalGuest;
      _priceController.text = totalPrice.toString();
    });
  }

  void _decreaseGuests() {
    if (totalGuest > 0) {
      setState(() {
        totalGuest -= 5;
        _guestController.text = totalGuest.toString();
        totalPrice = widget.preOrderModel.menu.price * totalGuest;
        _priceController.text = totalPrice.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = PaymentConfig(
      amount: (totalPrice * 0.2 * 100).round(),
      productIdentity: widget.preOrderModel.menu.menuId,
      productName: widget.preOrderModel.menu.categoryName,
      additionalData: {
        'caterer_id': widget.preOrderModel.menu.userId,
        'customer_id': widget.preOrderModel.customerId,
        'product_id': widget.preOrderModel.menu.menuId,
        'order_date': widget.preOrderModel.date,
        'total_guests': widget.preOrderModel.totalGuests,
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text(
                'Contact Information',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 10.h),
              Card(
                elevation: 2,
                child: Container(
                  height: 140.h,
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
                  child: Column(
                    children: [
                      buildContactInfo(
                        context,
                        widget.preOrderModel.name,
                        Icons.person_outline,
                      ),
                      const Spacer(),
                      buildContactInfo(
                        context,
                        widget.preOrderModel.phone,
                        Icons.phone,
                      ),
                      const Spacer(),
                      buildContactInfo(
                        context,
                        widget.preOrderModel.address,
                        Icons.location_pin,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Your Order Schedule',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      height: 74.h,
                      decoration: BoxDecoration(
                        color: Colors.yellow.withAlpha(150),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selected Date',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Colors.yellow.shade800,
                                    fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Text(
                            DateFormat('d MMM y').format(
                                DateTime.parse(widget.preOrderModel.date)),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              selectedTime = value.format(context);
                            });
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        height: 76.h,
                        decoration: BoxDecoration(
                          color: Colors.yellow.withAlpha(150),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selected Time',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: Colors.yellow.shade800,
                                      fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Text(
                              selectedTime,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Divider(color: Colors.grey.shade300),
              SizedBox(height: 14.h),
              Text(
                'Order Info',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 10.h),
              BuildTextField(
                controller: _menuController,
                labelText: 'Menu',
                isEnabled: false,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 130.w,
                    child: BuildTextField(
                      controller: _priceController,
                      labelText: 'Price',
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.people_alt_rounded,
                          size: 24,
                          color: AppColor.primaryRed,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _decreaseGuests();
                                },
                                iconSize: 20,
                                icon: const Icon(Icons.remove),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              SizedBox(
                                width: 50.w,
                                child: TextField(
                                    onSubmitted: (value) {
                                      setState(() {
                                        totalGuest = int.parse(value);
                                        totalPrice =
                                            widget.preOrderModel.menu.price *
                                                totalGuest;
                                        _priceController.text =
                                            totalPrice.toString();
                                      });
                                    },
                                    controller: _guestController,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 6),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    )),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              IconButton(
                                onPressed: () {
                                  _increaseGuests();
                                },
                                iconSize: 20,
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              const MySeparator(height: 1.2),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Grand Total',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 18.sp, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: 'en_np',
                      symbol: 'Rs. ',
                      decimalDigits: 0,
                    ).format(totalPrice),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColor.primaryRed),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              BuildButton(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  OrderModel orderModel = OrderModel(
                    orderId: "",
                    orderDetail: OrderDetail(
                        customerId: widget.preOrderModel.customerId,
                        customerName: widget.preOrderModel.name,
                        customerAddress: widget.preOrderModel.address,
                        customerPhone: widget.preOrderModel.phone,
                        dietaryPref: widget.preOrderModel.dietaryPref,
                        helpers: widget.preOrderModel.helpers,
                        orderDate: widget.preOrderModel.date,
                        totalGuests: widget.preOrderModel.totalGuests),
                    advancePayment: "${(totalPrice * 0.2).round()}",
                    price: totalPrice.toString(),
                    categoryId: widget.preOrderModel.menu.categoryId,
                    categoryName: widget.preOrderModel.menu.categoryName,
                    categoryImage: "",
                    catererId: widget.preOrderModel.menu.userId,
                    menuId: widget.preOrderModel.menu.menuId,
                    menuName: widget.preOrderModel.menu.categoryName,
                    orderStatus: OrderStatus.pending,
                    dessertMenu: widget.preOrderModel.dessertMenu,
                    mainCourseMenu: widget.preOrderModel.mainCourseMenu,
                    starterMenu: widget.preOrderModel.starterMenu,
                    user: const types.User(id: ''),
                  );
                  buildLoadingDialog(context, 'Placing Order!!');
                  KhaltiScope.of(context).pay(
                    config: config,
                    onSuccess: (value) async{
                      final response =
                          await OrderDataSource().placeOrder(orderModel);
                      navigator.pop();
                      if (response == 'Order Placed Successfully') {
                        await ChatDataSource().sendNotification(
                          token: widget.preOrderModel.user.metadata!['deviceToken'],
                          title: "New Order",
                          message:
                          "You have a new order from ${widget.preOrderModel.name}",
                          notificationData: {
                            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                            'name': widget.preOrderModel.name,
                            'type': 'order',
                            'route': 'order',
                          },
                        );
                        if (!context.mounted) return;
                        buildSuccessDialog(
                          context,
                          response,
                              () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, Routes.mainScreenRoute, (route) => false);
                          },
                        );
                      } else {
                        if (!context.mounted) return;
                        buildErrorDialog(
                          context,
                          'Could not place order\n Try again later!',
                        );
                      }
                    },
                    onFailure: (value) {
                      navigator.pop();
                      if (!context.mounted) return;
                      buildErrorDialog(
                        context,
                        'Could not place order\n Try again later!',
                      );
                    },
                    onCancel: (){
                      navigator.pop();
                      if (!context.mounted) return;
                      buildErrorDialog(
                        context,
                        "You've cancelled the order!",
                        title: 'Order Cancelled',
                      );
                    }
                  );
                },
                buttonWidget: const Text('Confirm'),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );

  }
  Row buildContactInfo(BuildContext context, String title, IconData iconData) {
    return Row(
      children: [
        Container(
          height: 34.h,
          width: 34.h,
          decoration: BoxDecoration(
              color: Colors.yellow, borderRadius: BorderRadius.circular(18.r)),
          child: Icon(
            iconData,
            size: 18,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}


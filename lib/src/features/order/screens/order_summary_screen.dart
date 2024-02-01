import 'package:catering_user_app/src/common/common_export.dart';
import 'package:catering_user_app/src/common/widgets/build_dialogs.dart';
import 'package:catering_user_app/src/features/order/data/order_datasource.dart';
import 'package:catering_user_app/src/features/order/domain/order_model.dart';
import 'package:catering_user_app/src/features/order/domain/pre_order_model.dart';
import 'package:catering_user_app/src/themes/export_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


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
        totalGuest-=5;
        _guestController.text = totalGuest.toString();
        totalPrice = widget.preOrderModel.menu.price * totalGuest;
        _priceController.text = totalPrice.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  height: 160.h,
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
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
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      height: 72.h,
                      decoration: BoxDecoration(
                        color: Colors.yellow.withAlpha(150),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selected Date',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.yellow.shade800,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          const Spacer(),
                          Text(
                            DateFormat('d MMM y').format(DateTime.parse(widget.preOrderModel.date)),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w,),
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
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.yellow.shade800,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            const Spacer(),
                            Text(
                              selectedTime,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800
                              ),
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
                    width: 140.w,
                    child: BuildTextField(
                      controller: _priceController,
                      labelText: 'Price',
                    ),
                  ),
                  SizedBox(width: 20.w,),
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Icons.people_alt_rounded, size: 24, color: AppColor.primaryRed,),
                        SizedBox(width: 10.w,),
                        Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8.w),
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
                                onPressed: (){
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
                                        totalPrice = widget.preOrderModel.menu.price * totalGuest;
                                        _priceController.text = totalPrice.toString();
                                      });
                                    },
                                    controller: _guestController,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: 6),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    )
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              IconButton(
                                onPressed: (){
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
              SizedBox(height: 30.h,),
              const MySeparator(height: 1.2),
              SizedBox(height: 30.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Grand Total',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800
                    ),
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
                      color: AppColor.primaryRed
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h,),
              BuildButton(
                onPressed: ()async{
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
                          totalGuests: widget.preOrderModel.totalGuests
                      ),
                      advancePayment: "",
                      price: widget.preOrderModel.menu.price.toString(),
                      categoryId: widget.preOrderModel.menu.categoryId,
                      categoryName: widget.preOrderModel.menu.categoryName,
                      categoryImage: "",
                      catererId: widget.preOrderModel.menu.userId,
                      menuId: widget.preOrderModel.menu.menuId,
                      menuName: widget.preOrderModel.menu.categoryName,
                      orderStatus: OrderStatus.pending,
                      dessertMenu: widget.preOrderModel.menu.dessertMenu,
                      mainCourseMenu: widget.preOrderModel.menu.mainCourseMenu,
                      starterMenu: widget.preOrderModel.menu.starterMenu,
                      user: const types.User(id: ''),
                  );
                  buildLoadingDialog(context, 'Placing Order!!');
                  final response = await OrderDataSource().placeOrder(orderModel);
                  navigator.pop();
                  if(response == 'Order Placed Successfully'){
                    if(!context.mounted) return;
                    buildSuccessDialog(context, 'Order Placed Successfully',
                    () {
                      Navigator.pushNamedAndRemoveUntil(context, Routes.homeRoute, (route) => false);
                    },
                    );
                  }else{
                    if(!context.mounted) return;
                    buildErrorDialog(context, 'Could not place order\n Try again later!',);
                  }
                },
                buttonWidget: const Text('Confirm'),
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



class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface),
              ),
            );
          }),
        );
      },
    );
  }
}
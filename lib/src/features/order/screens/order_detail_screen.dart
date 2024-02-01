import 'package:catering_user_app/src/common/common_export.dart';
import 'package:catering_user_app/src/common/widgets/build_dialogs.dart';
import 'package:catering_user_app/src/features/chat/data/chat_provider.dart';
import 'package:catering_user_app/src/features/chat/screens/chat_screen.dart';
import 'package:catering_user_app/src/features/order/data/order_provider.dart';
import 'package:catering_user_app/src/features/order/domain/order_model.dart';
import 'package:catering_user_app/src/features/order/screens/widgets/common_function.dart';
import 'package:catering_user_app/src/themes/export_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends ConsumerStatefulWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen> {
  final _textController = TextEditingController();
  final _reasonController = TextEditingController();
  late String formattedDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderDetail = ref.watch(orderDetailProvider(widget.orderId));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: orderDetail.when(
        data: (data) {
          _textController.text = data.orderDetail.dietaryPref;
          DateTime dateTime = DateTime.parse(data.orderDetail.orderDate);
          formattedDate = DateFormat('MMMM d').format(dateTime);
          final totalPrice = double.parse(data.price) *
              double.parse(data.orderDetail.totalGuests);
          return Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 170.h,
                  width: 290.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(data.categoryImage),
                      ),
                  ),
                ),
              ),
              Expanded(
                child: DraggableScrollableSheet(
                  initialChildSize: 0.94,
                  minChildSize: 0.94,
                  maxChildSize: 1.0,
                  shouldCloseOnMinExtent: false,
                  builder: (context, scrollController) {
                    return Container(
                      padding:
                      EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.15),
                              spreadRadius: 1.5,
                              blurRadius: 8,
                              offset: const Offset(0, -1),
                            ),
                          ]
                      ),
                      child: ListView(
                        controller: scrollController,
                        children: [
                          Text(
                            '${data.menuName} Party',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rs. ${data.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: AppColor.primaryRed,
                                    ),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 8.w),
                                height: 34.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: Colors.grey.shade600,
                                    ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.people),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      data.orderDetail.totalGuests,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Date',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: Colors.grey.shade600),
                                  ),
                                  Text(
                                    formattedDate,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Staff',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: Colors.grey.shade600),
                                  ),
                                  Text(
                                    data.orderDetail.helpers,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Total',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: Colors.grey.shade600),
                                  ),
                                  Text(
                                    'Rs. ${formatTotalPrice(totalPrice)}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          BuildTextField(
                            isEnabled: false,
                            controller: _textController,
                            maxLine: 2,
                            labelText: 'Dietary Preferences',
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Customer Details',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Name     :  ',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextSpan(
                                text: data.orderDetail.customerName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp),
                              ),
                            ],
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Address :  ',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                                TextSpan(
                                  text: data.orderDetail.customerAddress,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Phone    :  ',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                                TextSpan(
                                  text: data.orderDetail.customerPhone,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          data.orderStatus.index == 1
                              ? BuildButton(
                                  onPressed: () async{
                                    final navigator = Navigator.of(context);
                                    final scaffoldMessage = ScaffoldMessenger.of(context);
                                    final response = await ref.read(roomProvider).createRoom(data.user);
                                    if(response != null){
                                      navigator.push(
                                        MaterialPageRoute(
                                          builder: (_) => ChatScreen(room: response),
                                        ),
                                      );
                                    }else{
                                      scaffoldMessage.showSnackBar(
                                        const SnackBar(duration: Duration(milliseconds: 1500) , content: Text("something went wrong")),
                                      );
                                    }
                                  },
                                  buttonWidget: const Text('Message'),
                                )
                              : OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: AppColor.primaryRed,
                              ),
                            ),
                            onPressed: () {
                              buildRejectModal(context, data);
                            },
                            child: const Text('Cancel Order'),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
        error: (error, stackTrace) => Center(
          child: Text('$error'),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<dynamic> buildRejectModal(BuildContext context, OrderModel orderData) {
    return showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      enableDrag: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BuildTextField(
                  maxLine: 3,
                  autoFocus: true,
                  controller: _reasonController,
                  labelText: 'Reason',
                  hintText: 'Enter reason for cancellation',
                ),
                SizedBox(
                  height: 30.h,
                ),
                BuildButton(
                  onPressed: _reasonController.text.isEmpty
                      ? null
                      : () {
                          buildLoadingDialog(context, 'Rejecting');
                          ref.read(cancelOrderProvider(orderData.orderId));
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                  buttonWidget: const Text('Submit'),
                ),
                SizedBox(
                  height: 50.h,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:catering_user_app/src/common/common_export.dart';
import 'package:catering_user_app/src/features/order/data/order_provider.dart';
import 'package:catering_user_app/src/features/payment/data/payment_provider.dart';
import 'package:catering_user_app/src/features/payment/domain/payment_model.dart';
import 'package:catering_user_app/src/shared/data/user_provider.dart';
import 'package:catering_user_app/src/themes/export_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PaymentHistoryScreen extends ConsumerStatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  ConsumerState<PaymentHistoryScreen> createState() =>
      _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends ConsumerState<PaymentHistoryScreen>
    with TickerProviderStateMixin {
  void _copyToClipboard(BuildContext context, String textToCopy) {
    Navigator.pop(context);
    Clipboard.setData(ClipboardData(text: textToCopy));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        duration: const Duration(seconds: 2),
        animation: AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 800),
        ),
        margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 40.h),
        content: const Text('Text copied to clipboard'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final paymentData = ref.watch(paymentHistoryProvider);
    final formatter = NumberFormat.simpleCurrency(name: 'NPR ');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment History'),
      ),
      body: paymentData.when(
        data: (data) {
          final advanceAmount =
              data.map((e) => double.parse(e.amount)).toList();
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final payData = data[index];
                return InkWell(
                  onTap: () {
                    buildShowModalBottomSheet(context, theme, payData,
                        formatter, advanceAmount, index);
                  },
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10.r,
                      ), // Set the border radius here
                    ),
                    margin: const EdgeInsets.only(
                      bottom: 2,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 70.h,
                            width: 64.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              image: DecorationImage(
                                image: NetworkImage(
                                    payData.orderInfo.categoryImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${payData.orderInfo.menuName} Party",
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      formatter.format(advanceAmount[index]),
                                      style:
                                          theme.textTheme.labelLarge?.copyWith(
                                        color: AppColor.primaryRed,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.history,
                                          size: 18,
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          DateFormat('dd MMM yyyy').format(
                                              DateTime.parse(
                                                  payData.createdAt)),
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 22.h,
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                          color: Colors.green.shade400,
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          border: Border.all(
                                            color: Colors.green,
                                            width: 2.w,
                                          )),
                                      child: Center(
                                        child: Text(
                                          'Success',
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
                                            color: Colors.white,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Source: ',
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                      TextSpan(
                                        text: 'Khalti Wallet',
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(
      BuildContext context,
      ThemeData theme,
      PaymentDetailModel payData,
      NumberFormat formatter,
      List<double> advanceAmount,
      int index) {
    return showModalBottomSheet(
      useRootNavigator: false,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return Container(
          height: 300.h,
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Details',
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(height: 10.h),
              Text(
                'Transaction ID',
                style: theme.textTheme.bodyLarge,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    payData.idx,
                    style: theme.textTheme.bodyMedium,
                  ),
                  SizedBox(width: 5.w),
                  IconButton(
                    onPressed: () {
                      _copyToClipboard(context, payData.idx);
                    },
                    icon: Icon(Icons.copy_rounded, size: 20.sp),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date',
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    DateFormat('dd MMM yyyy')
                        .format(DateTime.parse(payData.createdAt)),
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Source',
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    'Khalti Wallet',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              const MySeparator(),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount',
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    formatter.format(advanceAmount[index]),
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

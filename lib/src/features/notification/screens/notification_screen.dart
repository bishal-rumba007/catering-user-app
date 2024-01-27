import 'package:catering_user_app/src/features/notification/screens/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Notifications'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: ListView.separated(
          padding: EdgeInsets.only(top: 14.h),
          itemCount: 20,
          itemBuilder: (context, index) {
            return const NotificationCard();
          },
          separatorBuilder: (context, index) => SizedBox(height: 14.h,),
        ),
      ),
    );
  }
}
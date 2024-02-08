import 'package:catering_user_app/src/common/common_export.dart';
import 'package:catering_user_app/src/features/notification/data/notification_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  const NotificationCard({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFDBDBDB),
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin:
                EdgeInsets.only(top: 5.h, right: 16.w, left: 2.w, bottom: 2.h),
            height: 12.h,
            width: 12.h,
            decoration: BoxDecoration(
              color: notification.isRead
                  ? theme.colorScheme.inverseSurface
                  : Colors.red,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: theme.textTheme.labelLarge,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  notification.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 18.sp,
                      color: theme.colorScheme.onSurface,
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Text(
                      '${formatDistanceToNowStrict(notification.createdAt)} ago',
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

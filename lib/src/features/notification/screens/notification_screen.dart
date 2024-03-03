import 'package:catering_user_app/src/features/notification/data/notification_list_provider.dart';
import 'package:catering_user_app/src/features/notification/screens/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationListProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Notifications'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: notifications.when(
          data: (data) {
            return data.isEmpty
                ? Center(
                    child: Text(
                      "No Notifications at the moment",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.only(top: 14.h),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          await ref
                              .read(notificationDataSourceProvider)
                              .updateNotificationReadStatus(
                                  data[index].notificationId);
                        },
                        child: NotificationCard(notification: data[index]),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 14.h,
                    ),
                  );
          },
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () =>
              const Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
    );
  }
}

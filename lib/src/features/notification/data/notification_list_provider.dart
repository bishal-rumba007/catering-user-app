



import 'package:catering_user_app/src/features/notification/data/notification_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationListProvider = StreamProvider((ref) => NotificationDataSource().getNotifications());
final notificationDataSourceProvider = Provider((ref) => NotificationDataSource());



import 'package:catering_user_app/src/api/api_keys.dart';
import 'package:catering_user_app/src/api/endpoints.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatDataSource{
  Future<void> sendNotification({required String title, required String message, Map<String, dynamic>? notificationData}) async {
    final token = await FirebaseMessaging.instance.getToken();
    final dio = Dio(
      BaseOptions(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        baseUrl: ApiEndPoints.baseNotificationUrl,
      )
    );
    try{
      await dio.post(
        ApiEndPoints.baseNotificationUrl,
        data: {
          "to": token,
          "priority": "High",
          "default_notification_channel_id": "high_importance_channel",
          "notification":{
            "body": message,
            "title": title,
          },
          "data": notificationData,
        }
      );

    }on FirebaseException catch (err){
      throw Exception(err.message);
    }
  }


}
import 'dart:io';

import 'package:catering_user_app/src/features/chat/data/chat_provider.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatelessWidget {
  final types.Room room;
  final String token;
  final String name;

  const ChatScreen(
      {super.key, required this.room, required this.token, required this.name});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final isLoad = ref.watch(loadingProvider);
        return Scaffold(
          body: SafeArea(
            child: StreamBuilder<List<types.Message>>(
              initialData: const [],
              stream: FirebaseChatCore.instance.messages(room),
              builder: (context, snapshot) {
                return Chat(
                  messages: snapshot.data ?? [],
                  onSendPressed: (value) async {
                    final dio = Dio();
                    FirebaseChatCore.instance.sendMessage(value, room.id);
                    try{
                      await dio.post('https://fcm.googleapis.com/fcm/send', data: {
                        "to": token,
                        "priority": "High",
                        "default_notification_channel_id": "high_importance_channel",
                        "notification":{
                          "body": value.text.trim(),
                          "title":"New Message",
                        },

                      }, options: Options(
                          headers:  {
                            'Authorization': 'key=AAAAD8GZyWs:APA91bELjX2lfw6syAbhStEhvC-qJ3FOsVdZurTxwHMoIuALvz-Hz9pMw2OKhGCFgItEREtymGZgyn9YTe1Dp0oAnEyurWBLqK5M42MfeeKRF7vJZ7zBgX88MBQDM9txvoX8DGMDzAPm'
                          }
                      ));
                    }catch(err){
                      print(err);
                    }
                  },
                  isAttachmentUploading: isLoad,
                  onAttachmentPressed: () async {
                    final result = await ImagePicker().pickImage(
                      imageQuality: 70,
                      maxWidth: 1440,
                      source: ImageSource.gallery,
                    );
                    if (result != null) {
                      ref.read(loadingProvider.notifier).toggle();
                      final file = File(result.path);
                      final size = file.lengthSync();

                      try {
                        final imageName = DateTime.now().toIso8601String();
                        final reference = FirebaseStorage.instance
                            .ref()
                            .child('chatImage/$imageName');
                        await reference.putFile(file);
                        final uri = await reference.getDownloadURL();

                        final message = types.PartialImage(
                          name: imageName,
                          size: size,
                          uri: uri,
                        );

                        FirebaseChatCore.instance.sendMessage(
                          message,
                          room.id,
                        );
                        ref.read(loadingProvider.notifier).toggle();
                      } catch (err) {
                        ref.read(loadingProvider.notifier).toggle();
                      }
                    }
                  },
                  showUserAvatars: true,
                  showUserNames: true,
                  theme: const DefaultChatTheme(
                    primaryColor: Color(0xff0084ff),
                  ),
                  user: types.User(
                      id: FirebaseChatCore.instance.firebaseUser?.uid ?? ""),
                  useTopSafeAreaInset: true,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

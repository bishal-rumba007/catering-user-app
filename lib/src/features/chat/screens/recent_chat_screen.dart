import 'package:catering_user_app/src/features/chat/data/chat_provider.dart';
import 'package:catering_user_app/src/features/chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class RecentChatScreen extends StatelessWidget {
  const RecentChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser =  FirebaseAuth.instance.currentUser!.uid;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Continue to chat with'),
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final roomData = ref.watch(roomStream);
            return roomData.when(
              data: (data){
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final otherUser = data[index].users.firstWhere((element) => element.id != currentUser);
                      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(data[index].updatedAt!);
                      String timeComponent = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
                      String amOrPm = dateTime.hour < 12 ? "AM" : "PM";
                      return Card(
                        elevation: 0,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                room: data[index],
                                token: otherUser.metadata?['deviceToken'],
                                name: otherUser.firstName!,
                              ),
                            ));
                          },
                          leading: CircleAvatar(
                            child: Text(data[index].name!.substring(0, 1), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                          ),
                          title: Text(data[index].name!, style: theme.textTheme.bodyLarge,),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(otherUser.metadata?['role'], style: theme.textTheme.labelSmall,),
                              const SizedBox(width: 10,),
                              Text('$timeComponent $amOrPm', style: theme.textTheme.labelSmall,),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              error: (error, stackTrace) => Center(child: Text("$error")),
              loading: () => const Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }
}
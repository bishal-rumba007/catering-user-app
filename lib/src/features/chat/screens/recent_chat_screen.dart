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
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0,
                        child: ListTile(
                          onTap: () {
                            final otherUser = data[index].users.firstWhere((element) => element.id != currentUser );
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
                          title: Text(data[index].name!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                          subtitle: Text(data[index].name!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
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
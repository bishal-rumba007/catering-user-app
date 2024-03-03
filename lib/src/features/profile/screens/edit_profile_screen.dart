import 'package:catering_user_app/src/common/common_export.dart';
import 'package:catering_user_app/src/shared/data/user_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';






class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userStream = ref.watch(singleUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: userStream.when(
          data: (data){
            nameController.text = data.firstName!;
            emailController.text = data.metadata!["email"];
            phoneController.text = data.metadata!["phone"];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h,),
                  BuildTextField(
                    controller: nameController,
                    hintText: 'John Doe',
                    labelText: 'Full Name',
                    isEnabled: false,
                  ),
                  SizedBox(height: 18.h,),
                  BuildTextField(
                    controller: emailController,
                    hintText: 'john@gmail.com',
                    labelText: 'Email',
                  ),
                  SizedBox(height: 18.h,),
                  BuildTextField(
                    controller: phoneController,
                    hintText: '9812345678',
                    labelText: 'Phone',
                  ),
                  SizedBox(height: 60.h,),
                  BuildButton(
                    onPressed: () async{
                      final userData = <String, dynamic>{
                        'metadata': {
                          'email': emailController.text.trim(),
                          'phone': phoneController.text.trim(),
                          'deviceToken': data.metadata!['deviceToken'] ?? await FirebaseMessaging.instance.getToken(),
                          'role': 'user',
                        }
                      };
                      await UserProvider().updateUser(userData).then((value) => Navigator.pop(context));
                    },
                    buttonWidget: const Text('Update'),
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) => Center(child: Text(error.toString()),),
          loading: () => const Center(child: CircularProgressIndicator(),)
      )
    );
  }
}

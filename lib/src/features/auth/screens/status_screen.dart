import 'package:catering_user_app/src/features/auth/screens/auth_provider.dart';
import 'package:catering_user_app/src/features/auth/screens/login_screen.dart';
import 'package:catering_user_app/src/features/dashboard/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(builder: (context, ref, child) {
      final authData = ref.watch(authStream);
      return authData.when(
        data: (data) {
          if (data == null) {
            return const LoginScreen();
          } else {
            return const MainScreen();
          }
        },
        error: (err, stack) => Center(child: Text('$err')),
        loading: () => const Center(child: CircularProgressIndicator()),
      );
    }));
  }
}

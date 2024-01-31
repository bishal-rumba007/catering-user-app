

import 'package:catering_user_app/src/features/auth/screens/login_screen.dart';
import 'package:catering_user_app/src/features/auth/screens/sign_up_screen.dart';
import 'package:catering_user_app/src/features/dashboard/screens/home_screen.dart';
import 'package:catering_user_app/src/features/menu/screens/menu_screen.dart';
import 'package:catering_user_app/src/features/notification/screens/notification_screen.dart';
import 'package:catering_user_app/src/features/order/screens/order_list_screen.dart';
import 'package:catering_user_app/src/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import 'common_export.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String menuRoute = '/menu';
  static const String notificationRoute = '/notification';
  static const String profileRoute = '/profile';
  static const String orderListRoute = '/order-list';
}

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.menuRoute:
        return MaterialPageRoute(builder: (_) => const MenuScreen());
      case Routes.notificationRoute:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
        case Routes.orderListRoute:
        return MaterialPageRoute(builder: (_) => const OrderListScreen());
      default:
        return unDefinedRoute();
    }
  }
  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Invalid Route'),
        ),
        body: const Center(child: Text('Route does not exist')),
      ),
    );
  }
}

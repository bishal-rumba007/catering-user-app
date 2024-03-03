import 'package:catering_user_app/src/features/auth/screens/login_screen.dart';
import 'package:catering_user_app/src/features/auth/screens/sign_up_screen.dart';
import 'package:catering_user_app/src/features/chat/screens/recent_chat_screen.dart';
import 'package:catering_user_app/src/features/dashboard/screens/home_screen.dart';
import 'package:catering_user_app/src/features/dashboard/screens/main_screen.dart';
import 'package:catering_user_app/src/features/menu/screens/menu_screen.dart';
import 'package:catering_user_app/src/features/notification/screens/notification_screen.dart';
import 'package:catering_user_app/src/features/order/screens/order_list_screen.dart';
import 'package:catering_user_app/src/features/payment/screens/payment_history_screen.dart';
import 'package:catering_user_app/src/features/profile/screens/edit_profile_screen.dart';
import 'package:catering_user_app/src/features/profile/screens/profile_screen.dart';
import 'package:catering_user_app/src/features/profile/screens/service_history_screen.dart';
import 'package:catering_user_app/src/features/profile/screens/support_screen.dart';
import 'package:catering_user_app/src/features/search/screen/search_screen.dart';
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
  static const String recentChats = '/recent-chat';
  static const String chatRoute = '/chat';
  static const String searchRoute = '/search';
  static const String mainScreenRoute = '/main-screen';
  static const String paymentHistoryRoute = '/payment-history';
  static const String serviceHistoryRoute = '/service-history';
  static const String supportRoute = '/support';
  static const String profileEditRoute = '/profile-edit';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
      case Routes.recentChats:
        return MaterialPageRoute(builder: (_) => const RecentChatScreen());
      case Routes.searchRoute:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case Routes.mainScreenRoute:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case Routes.paymentHistoryRoute:
        return MaterialPageRoute(builder: (_) => const PaymentHistoryScreen());
      case Routes.serviceHistoryRoute:
        return MaterialPageRoute(builder: (_) => const ServiceHistoryScreen());
      case Routes.supportRoute:
        return MaterialPageRoute(builder: (_) => const SupportScreen());
        case Routes.profileEditRoute:
          return MaterialPageRoute(builder: (_) => const ProfileEditScreen());
      ///Todo: Figure out route that requires parameters
      // case Routes.chatRoute:
      //   return MaterialPageRoute(builder: (_) => const ChatScreen(room: argument,));
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

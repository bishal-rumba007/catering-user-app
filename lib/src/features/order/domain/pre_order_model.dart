



import 'package:catering_user_app/src/features/menu/domain/models/menu_model.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class PreOrderModel{
  final String customerId;
  final String date;
  final String name;
  final String address;
  final String phone;
  final String dietaryPref;
  final String helpers;
  final String totalGuests;
  final Menus menu;
  final types.User user;
  final List<String> starterMenu;
  final List<String> mainCourseMenu;
  final List<String> dessertMenu;

  PreOrderModel({
    required this.customerId,
    required this.date,
    required this.name,
    required this.address,
    required this.phone,
    required this.dietaryPref,
    required this.helpers,
    required this.totalGuests,
    required this.menu,
    required this.user,
    required this.starterMenu,
    required this.dessertMenu,
    required this.mainCourseMenu,
  });
}
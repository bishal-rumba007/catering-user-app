



import 'package:catering_user_app/src/features/menu/domain/models/menu_model.dart';

class PreOrderModel{
  final String date;
  final String name;
  final String address;
  final String phone;
  final String dietaryPref;
  final String helpers;
  final String totalGuests;
  final Menus menu;

  PreOrderModel({
    required this.date,
    required this.name,
    required this.address,
    required this.phone,
    required this.dietaryPref,
    required this.helpers,
    required this.totalGuests,
    required this.menu,
  });
}
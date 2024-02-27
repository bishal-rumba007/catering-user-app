


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildSnackBar{
  static SnackBar buildSnackBar(String message, {Color color = Colors.green}){
    return  SnackBar(
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      duration: const Duration(seconds: 2),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      content: Center(child: Text(message)),
    );
  }
}
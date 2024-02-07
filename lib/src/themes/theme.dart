import 'package:catering_user_app/src/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  splashColor: AppColor.primaryRed.withOpacity(0.5),
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    onBackground: AppColor.darkColor.withOpacity(0.4),
    primary: AppColor.primaryRed,
    secondary: AppColor.secondaryColor,
    brightness: Brightness.dark,
    surface: Colors.grey.shade800,
    onSurface: const Color(0xFFf5f5f5),
    surfaceVariant: Colors.grey.shade700,
    inverseSurface: Colors.grey.shade50,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade900,
    titleTextStyle: GoogleFonts.inter(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.darkModeText,
    ),
    iconTheme: const IconThemeData(
      color: AppColor.darkModeText,
    ),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 42.sp,
      fontWeight: FontWeight.w900,
      color: AppColor.darkModeText,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 40.sp,
      fontWeight: FontWeight.w700,
      color: AppColor.darkModeText,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 36.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.darkModeText,
    ),
    headlineLarge: GoogleFonts.inter(
      fontSize: 32.sp,
      fontWeight: FontWeight.w700,
      color: AppColor.darkModeText,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 28.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.darkModeText,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      color: AppColor.darkModeText,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
      color: AppColor.darkModeText,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.darkModeText,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.darkModeText,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.darkModeText,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.darkModeText,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColor.darkModeText,
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.darkModeText,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.darkModeText,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.darkModeText,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: Size(double.infinity, 50.h),
      textStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        color: Colors.white,
      ),
      foregroundColor: Colors.white,
      elevation: 2,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: Size(double.infinity, 50.h),
      textStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        color: Colors.white,
      ),
      backgroundColor: AppColor.primaryRed,
      foregroundColor: Colors.white,
      elevation: 2,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: AppColor.greyColor, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: AppColor.primaryRed, width: 1.5),
    ),
    labelStyle: GoogleFonts.inter(
      fontSize: 13.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.darkModeText,
    ),
    hintStyle: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.darkModeText,
    ),
    floatingLabelStyle: GoogleFonts.inter(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.primaryRed,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: AppColor.primaryRed, width: 1.5),
    ),
    errorStyle: GoogleFonts.inter(
      fontSize: 14.sp,
      color: Colors.red,
    ),
  ),
  chipTheme: ChipThemeData(
    selectedColor: AppColor.primaryRed,
    secondarySelectedColor: AppColor.primaryRed,
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
    labelStyle: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    secondaryLabelStyle: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.grey.shade600,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(8.r),
    ),
  ),
);

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  splashColor: AppColor.primaryRed.withOpacity(0.5),
  colorScheme: ColorScheme.light(
    background: AppColor.backGroundColor,
    onBackground: AppColor.darkColor,
    primary: AppColor.primaryRed,
    secondary: AppColor.secondaryColor,
    surface: Colors.white,
    surfaceVariant: AppColor.backGroundColor,
    inverseSurface: Colors.grey.shade400,
  ),
  iconTheme: IconThemeData(
    color: AppColor.darkColor,
  ),
  disabledColor: AppColor.darkColor,
  cardTheme: const CardTheme(
    color: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColor.backGroundColor,
    titleTextStyle: GoogleFonts.inter(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.darkColor,
    ),
    actionsIconTheme: IconThemeData(
      color: AppColor.darkColor.withOpacity(0.8),
    ),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 42.sp,
      fontWeight: FontWeight.w900,
      color: AppColor.darkColor,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 40.sp,
      fontWeight: FontWeight.w400,
      color: AppColor.darkColor,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 36.sp,
      fontWeight: FontWeight.w400,
      color: AppColor.darkColor,
    ),
    headlineLarge: GoogleFonts.inter(
      fontSize: 32.sp,
      fontWeight: FontWeight.w700,
      color: AppColor.darkColor,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 28.sp,
      fontWeight: FontWeight.w400,
      color: AppColor.darkColor,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      color: AppColor.darkColor,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
      color: AppColor.darkColor,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.darkColor,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.darkColor,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.darkColor,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.darkColor,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColor.darkColor,
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.darkColor,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.darkColor,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.darkColor,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColor.greyColor.withOpacity(0.5);
          }
          return Colors.transparent;
        },
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          color: AppColor.greyColor,
        ),
      ),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColor.greyColor;
          }
          return AppColor.greyColor; // Customize the button text color
        },
      ),
      side: MaterialStateProperty.all<BorderSide>(
        const BorderSide(
          color: AppColor.greyColor,
          width: 1,
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      disabledBackgroundColor: AppColor.primaryRed.withOpacity(0.5),
      minimumSize: Size(double.infinity, 50.h),
      textStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        color: Colors.white,
      ),
      backgroundColor: AppColor.primaryRed,
      foregroundColor: Colors.white,
      elevation: 2,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: AppColor.greyColor, width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide:
          BorderSide(color: AppColor.greyColor.withOpacity(0.8), width: 1.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: AppColor.greyColor, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: AppColor.primaryRed, width: 1.5),
    ),
    labelStyle: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.darkColor.withOpacity(0.6),
    ),
    hintStyle: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.darkColor.withOpacity(0.6),
    ),
    floatingLabelStyle: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.primaryRed,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: AppColor.setOrange, width: 1.5),
    ),
    errorStyle: GoogleFonts.inter(
      fontSize: 14.sp,
      color: Colors.red,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  chipTheme: ChipThemeData(
    selectedColor: AppColor.primaryRed,
    secondarySelectedColor: AppColor.primaryRed,
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
    labelStyle: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.darkColor,
    ),
    secondaryLabelStyle: GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.darkColor,
    ),
    shape: RoundedRectangleBorder(
      side: const BorderSide(
        color: AppColor.greyColor,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(8.r),
    ),
  ),
);

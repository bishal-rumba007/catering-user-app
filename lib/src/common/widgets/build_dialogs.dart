import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



buildErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Icon(Icons.warning_rounded, size: 70.h,),
            SizedBox(height: 10.h,),
            Text(
              'Something went wrong!',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      );
    },
  );
}



Future<void> buildLoadingDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20.h,
            ),
            const CircularProgressIndicator(),
            SizedBox(
              height: 30.h,
            ),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      );
    },
  );
}


buildSuccessDialog(BuildContext context, String message, VoidCallback onPressed) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Icon(Icons.check_circle, size: 70.h,),
            SizedBox(height: 10.h,),
            Text(
              'Operation Successful!!',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
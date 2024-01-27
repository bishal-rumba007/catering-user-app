
import 'package:catering_user_app/src/common/common_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CarouselCard extends StatelessWidget {
  const CarouselCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow,
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.55),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        height: 130.h,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: '30% OFF',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 17.sp),
                    ),
                    TextSpan(
                      text: ' on all \n categories',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 15.sp, fontWeight: FontWeight.w600),
                    )
                  ]),
                ),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                  width: 104.w,
                  height: 32.h,
                  child: BuildButton(
                    onPressed: () {},
                    buttonStyle: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.all(5.w),
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    buttonWidget: const Text(
                      'Accept Now',
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 34.w,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhjY_J2A-6p8NNQGmCLfsSbjR8RaRinc1p2g",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
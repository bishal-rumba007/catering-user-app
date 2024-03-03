
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CarouselCard extends StatefulWidget {
  const CarouselCard({
    super.key,
  });

  @override
  State<CarouselCard> createState() => _CarouselCardState();
}

class _CarouselCardState extends State<CarouselCard> {
  final List<String> imgList = [
    "https://templates.simplified.co/usetldr/127795/thumb/4de85ca4-ed73-4599-acb0-10303d40dc70.jpg",
    "https://templates.simplified.co/usetldr/971783/thumb/438fe01c-bf1b-43de-98a5-69aab0d2ff4c.jpg",
    "https://arzfinefoods.com/wp-content/uploads/2018/11/Catering_Promo.jpg",
  ];
  final carouselController = CarouselController();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: imgList
          .map(
            (item) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            image: DecorationImage(
              image: NetworkImage(item),
              fit: BoxFit.cover,
            ),
          ),
        ),
      )
          .toList(),
      options: CarouselOptions(
        height: 140.h,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
        aspectRatio: 2.0,
        initialPage: 2,
      ),
    );
    // return Card(
    //   color: Colors.yellow,
    //   elevation: 3,
    //   shadowColor: Colors.black.withOpacity(0.55),
    //   child: Container(
    //     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
    //     height: 130.h,
    //     width: double.infinity,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             RichText(
    //               text: TextSpan(children: [
    //                 TextSpan(
    //                   text: '30% OFF',
    //                   style: Theme.of(context)
    //                       .textTheme
    //                       .headlineSmall
    //                       ?.copyWith(fontSize: 17.sp),
    //                 ),
    //                 TextSpan(
    //                   text: ' on all \n categories',
    //                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
    //                       fontSize: 15.sp, fontWeight: FontWeight.w600),
    //                 )
    //               ]),
    //             ),
    //             SizedBox(
    //               height: 12.h,
    //             ),
    //             SizedBox(
    //               width: 104.w,
    //               height: 32.h,
    //               child: BuildButton(
    //                 onPressed: () {},
    //                 buttonStyle: ElevatedButton.styleFrom(
    //                   backgroundColor: Colors.red,
    //                   padding: EdgeInsets.all(5.w),
    //                   textStyle: Theme.of(context)
    //                       .textTheme
    //                       .bodySmall
    //                       ?.copyWith(
    //                       fontSize: 12.sp,
    //                       fontWeight: FontWeight.w600,
    //                       color: Colors.white),
    //                 ),
    //                 buttonWidget: const Text(
    //                   'Accept Now',
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //         SizedBox(
    //           width: 34.w,
    //         ),
    //         Expanded(
    //           child: Container(
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(10.r),
    //               image: const DecorationImage(
    //                 fit: BoxFit.cover,
    //                 image: NetworkImage(
    //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhjY_J2A-6p8NNQGmCLfsSbjR8RaRinc1p2g",
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
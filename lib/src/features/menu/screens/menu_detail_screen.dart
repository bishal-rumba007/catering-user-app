
import 'package:catering_user_app/src/common/common_export.dart';
import 'package:catering_user_app/src/features/menu/domain/models/menu_model.dart';
import 'package:catering_user_app/src/features/menu/screens/booking_screen.dart';
import 'package:catering_user_app/src/themes/export_themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class MenuDetailScreen extends ConsumerStatefulWidget {
  final Menus menuData;
  const MenuDetailScreen({super.key, required this.menuData});

  @override
  ConsumerState<MenuDetailScreen> createState() => MenuDetailScreenState();
}

class MenuDetailScreenState extends ConsumerState<MenuDetailScreen> {
  final _guestController = TextEditingController();


  int totalGuests = 20;

  @override
  void initState() {
    super.initState();
    _guestController.text = totalGuests.toString();
  }

  void _increaseGuests() {
    setState(() {
      totalGuests += 5;
      _guestController.text = totalGuests.toString();
    });
  }

  void _decreaseGuests() {
    if (totalGuests > 0) {
      setState(() {
        totalGuests-=5;
        _guestController.text = totalGuests.toString();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final menuDetail = widget.menuData;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Menu Detail'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 180.h,
              width: 300.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(menuDetail.categoryImage),
                ),
              ),
            ),
          ),
          Expanded(
            child: DraggableScrollableSheet(
              initialChildSize: 0.94,
              minChildSize: 0.94,
              maxChildSize: 1.0,
              shouldCloseOnMinExtent: false,
              builder: (context, scrollController) {
                return Card(
                  elevation: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.r),
                      ),
                  ),
                  child: Container(
                    padding:
                    EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.r),
                        ),
                    ),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Text(
                          '${menuDetail.categoryName} Party',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(height: 5.h,),
                        Text(
                          'Menu by: ${menuDetail.providerName}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 15.sp
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rs. ${menuDetail.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall,
                            ),
                            Row(
                              children: [
                                Icon(Icons.people_alt_rounded, size: 26, color: Colors.grey.shade600,),
                                SizedBox(width: 10.w,),
                                Container(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 8.w),
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 32.h,
                                        width: 32.h,
                                        child: IconButton(
                                          onPressed: (){
                                            _decreaseGuests();
                                          },
                                          iconSize: 20,
                                          icon: const Icon(Icons.remove),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      SizedBox(
                                        width: 50.w,
                                        child: TextField(
                                            onSubmitted: (value) {
                                              setState(() {
                                                totalGuests = int.parse(value);
                                              });
                                            },
                                            controller: _guestController,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.only(bottom: 12),
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            )
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      SizedBox(
                                        height: 32.h,
                                        width: 32.h,
                                        child: IconButton(
                                          onPressed: (){
                                            _increaseGuests();
                                          },
                                          iconSize: 20,
                                          icon: const Icon(Icons.add),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('About Menu', style: Theme.of(context).textTheme.titleLarge,),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: '⭐ 4.8 ', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold
                                  ),),
                                  TextSpan(
                                      text: '(67 Reviews)', style: Theme.of(context).textTheme.bodyMedium),
                                ]
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14.h,),
                        ReadMoreText(
                          menuDetail.menuDescription,
                          trimLines: 4,
                          trimMode: TrimMode.Line,
                          colorClickableText: AppColor.primaryRed,
                          trimCollapsedText: 'Read more',
                          trimExpandedText: 'Read less',
                          textAlign: TextAlign.justify,
                          moreStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColor.primaryRed,
                          ),
                          lessStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColor.primaryRed,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        BuildButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BookingScreen(
                                    menuData: menuDetail,
                                    totalGuests: totalGuests
                                ) ,
                              ),
                            );
                          },
                          buttonWidget: const Text('Book Now'),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
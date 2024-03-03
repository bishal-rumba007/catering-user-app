
import 'package:catering_user_app/src/common/common_export.dart';
import 'package:catering_user_app/src/features/menu/domain/models/menu_model.dart';
import 'package:catering_user_app/src/features/menu/screens/booking_screen.dart';
import 'package:catering_user_app/src/features/review/domain/review_model.dart';
import 'package:catering_user_app/src/themes/export_themes.dart';
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
    final reviewList = menuDetail.reviews;
    num totalRating = reviewList!.isEmpty ? 0 :
    num.parse((reviewList.map((e) => e.rating).reduce((value, element) => value + element) /
        reviewList.length).toStringAsFixed(1));

    int totalReview = reviewList.length;
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
                return Container(
                  padding:
                  EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.15),
                        spreadRadius: 1.5,
                        blurRadius: 8,
                        offset: const Offset(0, -1),
                      ),
                    ]
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
                          SizedBox(
                            child: Text(
                              'Rs. ${menuDetail.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium?.copyWith(
                                color: AppColor.primaryRed,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.people_alt_rounded, size: 24,),
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('About Menu', style: Theme.of(context).textTheme.titleLarge,),
                          TextButton(
                            onPressed: (){
                              totalReview > 0 ? buildShowModalBottomSheet(context, reviewList) : null;
                            },
                            child: RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(text: '⭐ $totalRating ', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold
                                    ),),
                                    TextSpan(
                                        text: totalReview > 1 ? '($totalReview Reviews)' : '($totalReview Review)', style: Theme.of(context).textTheme.bodyMedium),
                                  ]
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5.h,),
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
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context,
      List<ReviewModel> reviewList) {
    return showModalBottomSheet(
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(18.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Reviews",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 20.h,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final review = reviewList[index];
                    final userName = review.userName.split(" ");
                    return SizedBox(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 32.r,
                            backgroundColor: AppColor.secondaryColor,
                            child: Center(child: Text(userName[0][0] + userName[1][0])),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      review.userName,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    Text(
                                      '${formatDistanceToNowStrict(review.createdAt)} ago',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: List.generate(
                                        review.rating.floor(),
                                        (index) => const Icon(
                                          Icons.star_rate_rounded,
                                          color: Color(0xffffc700),
                                        ),
                                      ),
                                    ),
                                    if (review.rating % 1 != 0)
                                      const Icon(
                                        Icons.star_half_rounded,
                                        color: Color(0xffffc700),
                                      ),
                                    Row(
                                      children: List.generate(
                                        5 - review.rating.ceil(),
                                        (index) => Icon(
                                          Icons.star_border_rounded,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  review.review,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 28.h,
                  ),
                  itemCount: reviewList.length,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
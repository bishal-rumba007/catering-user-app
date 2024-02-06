
import 'package:catering_user_app/src/features/menu/domain/models/menu_model.dart';
import 'package:catering_user_app/src/features/menu/screens/menu_detail_screen.dart';
import 'package:catering_user_app/src/themes/export_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularMenuCard extends StatelessWidget {
  final List<Menus> menuData;
  const PopularMenuCard({
    super.key, required this.menuData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Menu',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontSize: 18.sp),
        ),
        SizedBox(
          height: 10.h,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: menuData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.w,
              childAspectRatio: 0.89
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MenuDetailScreen(
                          menuData: menuData[index],
                        ),
                    ),
                );
              },
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 140.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(menuData[index].categoryImage)
                                )
                            ),
                          ),
                          Positioned(
                            left: 10.w,
                            bottom: 10.h,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w,),
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: AppColor.primaryRed.withOpacity(0.80),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Text(
                                    '${menuData[index].categoryName} Menu',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rs. ${menuData[index].price}',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryRed
                            ),
                          ),
                          Text(
                            '3.2 ⭐',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColor.containerColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Per person',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
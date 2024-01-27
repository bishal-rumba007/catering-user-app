
import 'package:catering_user_app/src/features/menu/domain/models/menu_model.dart';
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
            return Card(
              elevation: 1,
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 90.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12.r),
                          ),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(menuData[index].categoryImage)
                          )
                      ),
                    ),
                    SizedBox(height: 6.h,),
                    Text(
                      '${menuData[index].categoryName} Menu',
                      style: Theme.of(context).textTheme.bodySmall
                    ),
                    const Spacer(),
                    Text(
                      'Per person',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 10.sp
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rs. ${menuData[index].price}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.primaryRed
                          ),
                        ),
                        const Text('⭐ 3.2'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
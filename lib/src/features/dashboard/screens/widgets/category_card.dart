

import 'package:catering_user_app/src/features/menu/data/menu_data_provider.dart';
import 'package:catering_user_app/src/features/menu/domain/models/menu_model.dart';
import 'package:catering_user_app/src/themes/export_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final categoryData = ref.watch(menuProvider);
        return categoryData.when(
          data: (data) {
            // Create a set to keep track of unique categoryIds
            final Set<String> uniqueCategoryIds = {};

            // Create a new list to store menus with unique categoryIds
            final List<Menus> uniqueMenus = [];

            for (final menu in data) {
              final categoryId = menu.categoryId;

              // Check if the categoryId is unique
              if (!uniqueCategoryIds.contains(categoryId)) {
                // If unique, add to the set, add the menu to the new list, and build the category
                uniqueCategoryIds.add(categoryId);
                uniqueMenus.add(menu);
              }
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontSize: 18.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CategoryCard(menuData: uniqueMenus),
              ],
            );
          },
          error: (error, stackTrace) => Center(
            child: Text('$error'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}



class CategoryCard extends StatefulWidget {
  final List<Menus> menuData;
  const CategoryCard({super.key, required this.menuData});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}
class _CategoryCardState extends State<CategoryCard> {
  int selectedCategory = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.menuData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = index;
              });
              // Todo: add routing logic here
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  elevation: 3.0,
                  child: Container(
                    height: 62.h,
                    width: 60.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.menuData[index].categoryImage)),
                        border: index == selectedCategory
                            ? Border.all(
                          color: AppColor.primaryRed,
                          width: 1.8.w,
                        )
                            : const Border()),
                  ),
                ),
                const Spacer(),
                Text(
                  widget.menuData[index].categoryName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      color: index == selectedCategory
                          ? AppColor.primaryRed
                          : AppColor.greyColor),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 15.w,
        ),
      ),
    );
  }
}

import 'package:catering_user_app/src/common/common_export.dart';
import 'package:catering_user_app/src/features/menu/domain/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuDetailScreen extends ConsumerStatefulWidget {
  final Menus menuData;
  const MenuDetailScreen({super.key, required this.menuData});

  @override
  ConsumerState<MenuDetailScreen> createState() => MenuDetailScreenState();
}

class MenuDetailScreenState extends ConsumerState<MenuDetailScreen> {

  @override
  void initState() {
    super.initState();
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
                          top: Radius.circular(30.r))),
                  child: Container(
                    padding:
                    EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.r),
                        )),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Text(
                          '${menuDetail.categoryName} Party',
                          style: Theme.of(context).textTheme.headlineSmall,
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
                            Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 8.w),
                              height: 34.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.people),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    "12",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Date',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                      color: Colors.grey.shade600),
                                ),
                                Text(
                                  "12 Jan",
                                  style:
                                  Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Staff',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                      color: Colors.grey.shade600),
                                ),
                                Text(
                                  "6",
                                  style:
                                  Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Total',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                      color: Colors.grey.shade600),
                                ),
                                Text(
                                  'Rs. ${menuDetail.price}',
                                  style:
                                  Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),

                        SizedBox(
                          height: 30.h,
                        ),
                        BuildButton(
                          onPressed: () {},
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
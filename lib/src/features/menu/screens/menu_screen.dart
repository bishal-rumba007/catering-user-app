import 'package:catering_user_app/src/features/menu/data/menu_data_provider.dart';
import 'package:catering_user_app/src/features/menu/domain/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menus'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => const CreateMenuScreen(),
              //   ),
              // );
            },
            icon: const Icon(
              Icons.add,
              size: 26,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Consumer(
              builder: (context, ref, child) {
                final menuData = ref.watch(menuProvider);
                return menuData.when(
                  data: (data) {
                    return MenuCard(
                      data: data,
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
            ),
        ),
      ),
    );
  }
}

class MenuCard extends StatefulWidget {
  const MenuCard({
    super.key,
    required this.data,
  });

  final List<Menus> data;

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 18.h,
        ),
        widget.data.isEmpty
            ? const Center(child: Text('No Available Menu right now!'),
        )
            : ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            final menu = widget.data[index];
            return Consumer(
              builder: (context, ref, child) {
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      useSafeArea: true,
                      showDragHandle: true,
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: Theme.of(context).colorScheme.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.r)),
                      ),
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(16.w),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                              children: [
                                ExpansionTile(
                                  title: Text(
                                      'Starters',
                                      style: Theme.of(context).textTheme.bodyLarge
                                  ),
                                  children: [
                                    for (String item
                                    in menu.starterMenu)
                                      ListTile(
                                        title: Text(
                                          item,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                ExpansionTile(
                                  title: Text(
                                      'Main Course',
                                      style: Theme.of(context).textTheme.bodyLarge
                                  ),
                                  children: [
                                    for (String item
                                    in menu.mainCourseMenu)
                                      ListTile(
                                        title: Text(
                                          item,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                ExpansionTile(
                                  title: Text(
                                      'Desserts',
                                      style: Theme.of(context).textTheme.bodyLarge
                                  ),
                                  children: [
                                    for (String item
                                    in menu.dessertMenu)
                                      ListTile(
                                        title: Text(
                                          item,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Card(
                    elevation: 2.0,
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      height: 110.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 100.w,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(14.r),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        menu.categoryImage),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                menu.categoryName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                menu.providerName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                'Starting from',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                  fontSize: 12.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                'Rs. ${menu.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: 10.h,
          ),
        )
      ],
    );
  }
}
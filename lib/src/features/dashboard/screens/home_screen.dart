
import 'package:catering_user_app/src/features/dashboard/screens/widgets/carousel_card.dart';
import 'package:catering_user_app/src/features/dashboard/screens/widgets/category_card.dart';
import 'package:catering_user_app/src/features/dashboard/screens/widgets/menu_widget.dart';
import 'package:catering_user_app/src/features/dashboard/screens/widgets/my_drawer.dart';
import 'package:catering_user_app/src/features/menu/data/menu_data_provider.dart';
import 'package:catering_user_app/src/shared/data/category_provider.dart';
import 'package:catering_user_app/src/themes/export_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int selectedCategory = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final menuData = ref.watch(menuProvider);
    // final categoryData = ref.watch(categoryProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                padding: EdgeInsets.all(16.w),
                child: SvgPicture.asset(
                  "assets/icons/menu.svg",
                  colorFilter: ColorFilter.mode(
                    Colors.grey.shade700,
                    BlendMode.srcIn
                  ),
                ),
              ),
            );
          },
        ),
        title: const Text('Catering'),
        centerTitle: true,
        titleTextStyle: GoogleFonts.beauRivage(
            fontWeight: FontWeight.w700,
            fontSize: 36.sp,
            color: AppColor.primaryRed,
            letterSpacing: 1.8,
        ),
        actions: [
          InkWell(
            splashFactory: InkRipple.splashFactory,
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Container(
                padding: EdgeInsets.all(5.5.w),
                width: 40.h,
                height: 40.h,
                child: SvgPicture.asset(
                    "assets/icons/search.svg",
                  colorFilter: ColorFilter.mode(
                      Colors.grey.shade700,
                      BlendMode.srcIn
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: menuData.when(
        data: (data) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  const CarouselCard(),
                  SizedBox(
                    height: 20.h,
                  ),
                  const CategoryWidget(),
                  SizedBox(
                    height: 16.h,
                  ),
                  data.isEmpty ?
                  Text(
                    'No Categories Available',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                      : PopularMenuCard(menuData: data,),
                  SizedBox(
                    height: 200.h,
                  ),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text('$error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

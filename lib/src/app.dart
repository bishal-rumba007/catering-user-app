import 'package:catering_user_app/src/common/common_export.dart';
import 'package:catering_user_app/src/themes/export_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 851),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightMode,
          darkTheme: darkMode,
          home: const SplashScreen(),
          navigatorKey: navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: Routes.splashRoute,
        );
      },
    );
  }
}

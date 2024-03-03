import 'package:catering_user_app/src/common/common_export.dart';
import 'package:catering_user_app/src/themes/export_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 873),
      builder: (context, child) {
        return KhaltiScope(
          publicKey: 'test_public_key_599f6b5632ee4bfabc89b6d5dc55234d',
          enabledDebugging: true,
          navigatorKey: navigatorKey,
          builder: (context, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: lightMode,
              darkTheme: darkMode,
              home: const SplashScreen(),
              navigatorKey: navigatorKey,
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: Routes.splashRoute,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ne', 'NP'),
              ],
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
            );
          },
        );
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/is_loged_in.dart';
import 'package:news_app/screens/auth/auth_screen.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/bottom_nav_bar.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/category_screen.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/home/home_screen.dart';
import 'package:news_app/screens/view_item_screen/view_screen.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('ar', ''), Locale('en', '')],
        path: 'assets/lang',
        fallbackLocale: const Locale('ar', ''),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          AuthScreen.id: (context) => IsLoggedIn(),
          HomeScreen.id: (context) => const HomeScreen(),
          BottomNavBarScreen.id: (context) => const BottomNavBarScreen(),
          CategoryScreen.id: (context) => const CategoryScreen(),
          ViewScreen.id: (context) => ViewScreen(),
        },
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Tajawal",
          primarySwatch: Colors.blue,
        ),
        initialRoute: AuthScreen.id,
      );
    });
  }
}

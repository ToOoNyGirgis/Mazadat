import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/constant.dart';
import 'package:news_app/cubits/user_data_cubit/user_data_cubit.dart';
import 'package:news_app/helper/is_loged_in.dart';
import 'package:news_app/helper/sqldb.dart';
import 'package:news_app/screens/auth/auth_screen.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/bottom_nav_bar.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/category_screen.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/filter_screen.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/sub_categories_screen.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/home/home_screen.dart';
import 'package:news_app/screens/view_item_screen/view_screen.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('ar', '')],
        path: 'assets/lang',
        fallbackLocale: const Locale('ar', ''),
        child: const MyApp()),
  );
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  SqlDb sqlDb = SqlDb();
  await sqlDb.insertData(
      'INSERT INTO "notification" ( $kNotificationBody, $kNotificationTitle) VALUES( "${message
          .notification!.body}", "${message.notification!.title}")');
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocProvider(
        create: (context) => UserDataCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AuthScreen.id,
          routes: {
            AuthScreen.id: (context) => const IsLoggedIn(),
            HomeScreen.id: (context) => const HomeScreen(),
            BottomNavBarScreen.id: (context) => const BottomNavBarScreen(),
            CategoryScreen.id: (context) => const CategoryScreen(),
            ViewScreen.id: (context) => const ViewScreen(),
            SubCategories.id: (context) => SubCategories(),
            FilterScreen.id: (context) => const FilterScreen(),
          },
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Mazadat',
          theme: ThemeData(
            fontFamily: "Tajawal",
            primarySwatch: Colors.blue,
          ),
        ),
      );
    });
  }
}

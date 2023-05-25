import 'package:flutter/material.dart';
import 'package:news_app/common/constant.dart';
import 'package:news_app/screens/auth/auth_screen.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IsLoggedIn extends StatefulWidget {
  const IsLoggedIn({super.key});

  @override
  IsLoggedInState createState() => IsLoggedInState();
}

class IsLoggedInState extends State<IsLoggedIn> {
  String? token;
  bool initial = true;

  @override
  Widget build(BuildContext context) {
    if (initial) {
      SharedPreferences.getInstance().then((sharedPrefValue) {
        setState(() {
          initial = false;
          token = sharedPrefValue.getString(kAccessTokenInPref);
        });
      });
      return const CircularProgressIndicator();
    } else {
      if (token == null) {
        return const AuthScreen();
      } else {
        return const BottomNavBarScreen();
      }
    }
  }
}

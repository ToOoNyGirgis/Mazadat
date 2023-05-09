import 'package:flutter/material.dart';
import 'package:news_app/common/constant.dart';
import 'package:news_app/screens/auth/auth_screen.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/bottom_nav_bar.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IsLoggedIn extends StatefulWidget {
  @override
  _IsLoggedInState createState() => _IsLoggedInState();
}

class _IsLoggedInState extends State<IsLoggedIn> {
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
      return CircularProgressIndicator();
    } else {
      if (token == null) {
        return AuthScreen();
      } else {
        return BottomNavBarScreen();
      }
    }
  }
}

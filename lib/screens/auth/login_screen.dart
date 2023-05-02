import 'package:flutter/material.dart';
import 'package:news_app/screens/auth/widgets/login_body.dart';
import 'package:news_app/screens/auth/widgets/register_body.dart';
import 'package:news_app/screens/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.id,
                (route) => false,
              );
            },
            icon: Icon(Icons.keyboard_backspace_outlined)),
        title: const Text('تسجيل الدخول'),
        centerTitle: true,
      ),
      body: LoginBody(),
    );
  }
}

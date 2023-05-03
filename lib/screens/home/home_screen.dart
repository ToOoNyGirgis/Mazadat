import 'package:flutter/material.dart';
import 'package:news_app/screens/auth/widgets/login_body.dart';
import 'package:news_app/screens/auth/widgets/register_body.dart';
import 'package:news_app/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'home';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('مزادات'),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'تسجيل الدخول',
                  ),
                ),
                Tab(
                  child: Text(
                    'التسجيل كمستخدم جديد',

                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: const [
              Expanded(
                child: TabBarView(children: [
                  LoginBody(),
                  RegisterBody(),
                ]),
              ),
            ],
          ),
        ));
  }
}

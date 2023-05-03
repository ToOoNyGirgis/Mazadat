import 'package:flutter/material.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/bottom_nav_bar.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/category_screen.dart';
import 'package:news_app/widgets/custom_button.dart';
import 'package:news_app/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const CustomTextField(
            keyboardType: TextInputType.phone,
            icon: Icons.phone,
            hint: 'ادخل رقم الهاتف',
          ),
          SizedBox(
            height: 1.5.h,
          ),
          const CustomTextField(
            obscureText: true,
            icon: Icons.password,
            hint: 'ادخل الرقم السري',
          ),

          SizedBox(
            height: 3.h,
          ),
          CustomButton(
            text: 'تسجيل الدخول',
            onTap: (){
              Navigator.pushNamed(context, BottomNavBarScreen.id);
            },
          ),
          SizedBox(
            height: 1.5.h,
          ),
        ],
      ),
    );
  }
}

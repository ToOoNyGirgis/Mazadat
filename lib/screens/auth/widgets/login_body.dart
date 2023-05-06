import 'package:flutter/material.dart';
import 'package:news_app/services/get_user.dart';
import 'package:news_app/widgets/custom_button.dart';
import 'package:news_app/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({
    super.key,
  });

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String errorString = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            controller: _mobileController,
            keyboardType: TextInputType.phone,
            icon: Icons.phone,
            hint: 'ادخل رقم الهاتف',
          ),
          SizedBox(
            height: 1.5.h,
          ),
          CustomTextField(
            controller: _passwordController,
            obscureText: true,
            icon: Icons.password,
            hint: 'ادخل الرقم السري',
          ),
          SizedBox(
            height: 3.h,
          ),
          CustomButton(
            text: 'تسجيل الدخول',
            onTap: () {
              GetUserService().login(context, {
                'mobile': _mobileController,
                'password': _passwordController,
              });
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

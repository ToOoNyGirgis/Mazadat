import 'package:flutter/material.dart';
import 'package:news_app/screens/auth/login_screen.dart';
import 'package:news_app/screens/category/category_screen.dart';
import 'package:news_app/widgets/custom_button.dart';
import 'package:news_app/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 4.h),
        child: Column(
          children: [
            const CustomTextField(
              hint: 'ادخل الاسم الاول',
              icon: Icons.text_format,
            ),
            SizedBox(
              height: 1.5.h,
            ),
            const CustomTextField(
              icon: Icons.text_format,
              hint: 'ادخل الاسم الثاني',
            ),
            SizedBox(
              height: 1.5.h,
            ),
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
              height: 1.5.h,
            ),
            const CustomTextField(
              obscureText: true,
              icon: Icons.check,
              hint: 'تأكيد الرقم السري',
            ),
            SizedBox(
              height: 3.h,
            ),
            CustomButton(
              text: 'تسجيل',
              onTap: () {
                Navigator.pushNamed(context, CategoryScreen.id);
              },
            ),
            SizedBox(
              height: 1.5.h,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_app/services/get_user.dart';
import 'package:news_app/widgets/custom_button.dart';
import 'package:news_app/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({
    super.key,
  });

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  String? mobile;
  String? name;
  String? lastName;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        child: Column(
          children: [
            CustomTextField(
              onChanged: (value) {
                name = value;
              },
              hint: 'ادخل الاسم الاول',
              icon: Icons.text_format,
            ),
            SizedBox(
              height: 1.5.h,
            ),
            CustomTextField(
              onChanged: (value) {
                lastName = value;
              },
              icon: Icons.text_format,
              hint: 'ادخل الاسم الثاني',
            ),
            SizedBox(
              height: 1.5.h,
            ),
            CustomTextField(
              onChanged: (value) {
                mobile = value;
              },
              keyboardType: TextInputType.phone,
              icon: Icons.phone,
              hint: 'ادخل رقم الهاتف',
            ),
            SizedBox(
              height: 1.5.h,
            ),
            CustomTextField(
              onChanged: (value) {
                password = value;
              },
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
                // Navigator.pushNamed(context, BottomNavBarScreen.id);
                GetUserService().register(context, {
                  'name': name,
                  'last_name': lastName,
                  'mobile': mobile,
                  'password': password,
                });
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

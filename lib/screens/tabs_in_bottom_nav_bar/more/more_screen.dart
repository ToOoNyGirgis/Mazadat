import 'package:flutter/material.dart';
import 'package:news_app/common/constant.dart';
import 'package:news_app/screens/auth/auth_screen.dart';
import 'package:news_app/widgets/custom_button.dart';
import 'package:news_app/widgets/custom_text_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4.w, /*vertical: 4.h*/
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  ListTile(
                    title: Text(
                      'الاسم : ',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    subtitle: Text(
                      'انطوان جرجس',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.edit)),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  ListTile(
                    trailing: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.edit)),
                    title: Text(
                      'رقم الهاتف : ',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    subtitle: Text(
                      '01272486778',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
              CustomButton(
                buttonColor: Colors.red,
                text: 'تسجيل الخروج',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('هل انت متأكد من تسجيل الخروج'),
                      actions: [
                        CustomTextButton(
                          text: 'الغاء',
                          textColor: Colors.red,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CustomTextButton(

                          text: 'موافق',
                          onPressed: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.remove(kAccessTokenInPref);
                            Navigator.pushNamedAndRemoveUntil(
                                context, AuthScreen.id, (route) => false);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

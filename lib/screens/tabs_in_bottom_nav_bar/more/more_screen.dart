import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/common/constant.dart';
import 'package:news_app/cubits/user_data_cubit/user_data_cubit.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/screens/auth/auth_screen.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/more/edit_data_screen.dart';
import 'package:news_app/services/get_user.dart';
import 'package:news_app/widgets/custom_button.dart';
import 'package:news_app/widgets/custom_text_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class MoreScreen extends StatelessWidget {
  MoreScreen({Key? key}) : super(key: key);
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<UserDataCubit, UserDataState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w, /*vertical: 4.h*/
              ),
              child: FutureBuilder(
                future: GetUserService().getUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> user = snapshot.data!;
                    return Column(
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
                                "${user['name']} ${user['last_name']}",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            ListTile(
                              title: Text(
                                'رقم الهاتف : ',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                              ),
                              subtitle: Text(
                                user['mobile'],
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomButton(
                              buttonColor: Colors.blue,
                              text: 'تعديل البيانات',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditDataScreen(
                                        name: user['name'],
                                        lastName: user['last_name'],
                                        mobile: user['mobile'],
                                      ),
                                    ));
                              },
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            CustomButton(
                              buttonColor: Colors.red,
                              text: 'تسجيل الخروج',
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                        'هل انت متأكد من تسجيل الخروج'),
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
                                              await SharedPreferences
                                                  .getInstance();
                                          pref.remove(kAccessTokenInPref);
                                          // pref.clear();
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              AuthScreen.id,
                                              (route) => false);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: CustomButton(
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
                                    // pref.clear();
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        AuthScreen.id, (route) => false);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

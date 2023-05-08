import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:news_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:news_app/helper/show_snack_bar.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/bottom_nav_bar.dart';
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
  String? mobile;
  String? password;
  // String errorString = "";
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, BottomNavBarScreen.id, (route) => false);
          isLoading = false;
        } else if (state is LoginFailure) {
          isLoading = false;
          showSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            child: Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    onChanged: (value) {
                      mobile = value;
                    },
                    keyboardType: TextInputType.phone,
                    icon: Icons.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ادخل رقم الهاتف';
                      }
                      final phoneRegex = RegExp(r'^01[0-2,5]{1}[0-9]{8}$');
                      if (!phoneRegex.hasMatch(value)) {
                        return 'ادخل رقم هاتف صحيح مثل (01200000000)';
                      }
                      return null;
                    },
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
                    height: 3.h,
                  ),
                  CustomButton(
                    text: 'تسجيل الدخول',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        BlocProvider.of<AuthCubit>(context).loginUser(
                          mobile: mobile!,
                          password: password!,
                        );
                      } else {
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    }
                    // Navigator.pushNamed(context, BottomNavBarScreen.id);
                    ,
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

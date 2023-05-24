import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:news_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:news_app/helper/show_snack_bar.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/bottom_nav_bar.dart';
import 'package:news_app/widgets/custom_button.dart';
import 'package:news_app/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class RegisterBody extends StatefulWidget {
  RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  String? mobile;

  String? password;

  String? name;

  String? lastName;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, BottomNavBarScreen.id, (route) => false);
          isLoading = false;
        } else if (state is RegisterFailure) {
          isLoading = false;
          showSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: false,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: Form(
                key: formKey,
                autovalidateMode: autovalidateMode,
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
                      keyboardType: TextInputType.phone,
                      icon: Icons.phone,
                      hint: 'ادخل رقم الهاتف',
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ادخل كلمة المرور';
                        }
                        if (value.length < 6) {
                          return 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';
                        }
                        return null;
                      },
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
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ادخل تأكيد الرقم السري';
                        }
                        if (value != password) {
                          return 'تأكيد الرقم السري غير مطابق للرقم السري';
                        }
                        return null;
                      },
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
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          BlocProvider.of<AuthCubit>(context).registerUser(
                            mobile: mobile!,
                            name: name!,
                            lastName: lastName!,
                            password: password!,
                          );
                        } else {
                          autovalidateMode = AutovalidateMode.always;
                          setState(() {});
                        }
                      },
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

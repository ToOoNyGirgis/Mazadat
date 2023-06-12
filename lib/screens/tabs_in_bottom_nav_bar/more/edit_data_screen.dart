import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/user_data_cubit/user_data_cubit.dart';
import 'package:news_app/services/get_user.dart';
import 'package:news_app/widgets/custom_button.dart';
import 'package:news_app/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class EditDataScreen extends StatelessWidget {
   EditDataScreen({Key? key, required this.name, required this.lastName, required this.mobile}) : super(key: key);
   String name;
   String lastName;
   String mobile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: CustomButton(
          text: 'حفظ',
          onTap: (){
            GetUserService().updateData({
              'name':name,
              'last_name':lastName,
              'mobile':mobile,
            });
            BlocProvider.of<UserDataCubit>(context).fetchData();
            Navigator.pop(context);

          },
        ),
      ),
      appBar: AppBar(
        title: Text("تعديل البيانات"),
      ),
      body:  Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                children: [
                  CustomTextField(hint: name,
                  onChanged: (value) {
                    name = value;
                  },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextField(hint: lastName,
                    onChanged: (value) {
                      lastName = value;
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextField(hint: mobile,
                    onChanged: (value) {
                      mobile = value;
                    },
                  ),
                ],
              ),
            )
    );
  }
}

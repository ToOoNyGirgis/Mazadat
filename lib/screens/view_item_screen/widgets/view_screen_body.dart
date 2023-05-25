import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ViewScreenBody extends StatelessWidget {
  const ViewScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                'عنوان',
                style: TextStyle(fontSize: 24.sp),
              ),
            ),
            SizedBox(height: 2.h,),
            Image.network(
                'https://1.bp.blogspot.com/-yZCnXzNGUEw/X7aM6REK_6I/AAAAAAAAXUM/K0uYnJfXFgIdlitdcX4TyJwBjmj7zABDACLcBGAsYHQ/w640-h428/%25D9%2583%25D9%258A%25D9%2581%25D9%258A%25D8%25A9%2B%25D8%25AA%25D8%25AC%25D9%2585%25D9%258A%25D8%25B9%2B%25D8%25AD%25D8%25A7%25D8%25B3%25D9%2588%25D8%25A8%2B%25D9%2584%25D9%2584%25D8%25A3%25D9%2584%25D8%25B9%25D8%25A7%25D8%25A8%2BPC%2BGamer%2B%25D8%25A8%25D8%25A3%25D8%25B1%25D8%25AE%25D8%25B5%2B%25D8%25AB%25D9%2585%25D9%2586%2B%25D9%2588%2B%25D8%25A3%25D9%2582%25D9%2588%25D9%2589%2B%25D8%25A7%25D9%2584%25D9%2585%25D9%2588%25D8%25A7%25D8%25B5%25D9%2581%25D8%25A7%25D8%25AA.webp'),
            SizedBox(height: 2.h,),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                'التوبيك',
                style: TextStyle(fontSize: 24.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

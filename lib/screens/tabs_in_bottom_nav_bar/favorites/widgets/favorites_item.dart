import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FavoritesItem extends StatelessWidget {
  const FavoritesItem({
    super.key,
    required this.category,
    required this.city,
  });
  final String category;
  final String city;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
      child: GestureDetector(
        onTap: (){

        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 5),
                  spreadRadius: 1,
                  blurRadius: 10),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'الفئة : $category',
                  style: TextStyle(fontSize: 18.sp),
                ),
                city != 'المدينة'
                    ? Text(
                        'المدينة : $city',
                        style: TextStyle(fontSize: 18.sp),
                      )
                    : Text(
                        'لا يوجد مدينة مختارة',
                        style: TextStyle(fontSize: 18.sp),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

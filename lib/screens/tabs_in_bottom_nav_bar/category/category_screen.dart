import 'package:flutter/material.dart';
import 'package:news_app/models/cities_model.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/widgets/category_body.dart';
import 'package:news_app/services/cities.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  static String id = 'category';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('الصفحة الرئيسية'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                builder: (context) => const FilterBottomSheet(),
              );
            },
            icon: const Icon(Icons.filter_list_alt),
          ),
        ],
      ),
      body: const CategoryBody(),
    );
  }
}

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CitiesModel>>(
      future: CityService().getCity(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final cities = snapshot.data!;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      height: 0.5.h,
                      width: 8.w,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        IconButton(
                          splashColor: Colors.transparent,
                          splashRadius: 22,
                          iconSize: 18.sp,
                          // padding: EdgeInsets.zero,
                          constraints: BoxConstraints(maxWidth: 40),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'المدينة',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: ListView.builder(
                    itemCount: cities.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.grey),
                        ),
                        onTap: () {},
                        title: Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Text(cities[index].name),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

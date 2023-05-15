import 'package:flutter/material.dart';
import 'package:news_app/models/cities_model.dart';
import 'package:news_app/services/cities.dart';
import 'package:sizer/sizer.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                splashColor: Colors.transparent,
                                splashRadius: 22,
                                iconSize: 18.sp,
                                constraints: const BoxConstraints(maxWidth: 40),
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
                          // TextButton(onPressed: (){
                          //   Navigator.pop(context, {
                          //     // 'name':'اسوان',
                          //     // 'id':2,
                          //   });
                          // }, child: Text('كل المدن'))
                        ],
                      ),
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
                          side: const BorderSide(color: Colors.grey),
                        ),
                        onTap: () {
                          Navigator.pop(context, {
                            'name':cities[index].name,
                            'id':cities[index].id,
                          });
                        },
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
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

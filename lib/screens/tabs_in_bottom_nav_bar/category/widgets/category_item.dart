import 'package:flutter/material.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:sizer/sizer.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({Key? key, required this.categories, required this.screenNameToNavigate , }) : super(key: key);
  CategoriesModel categories;
  final String screenNameToNavigate;
  int? categoryId;
  String? categoryName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        categoryId=categories.id;
        categoryName = categories.name;
        Navigator.pushNamed(context, screenNameToNavigate,
            arguments: {
          'categoryId':categoryId,
          'categoryName':categoryName,
            });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 15,
            child: Padding(
              padding:   EdgeInsets.symmetric(horizontal: 4.w,vertical:1.h ,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      categories.name,
                      style: TextStyle(
                        fontSize: 13.sp,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 4.h,
            top: -4.h,
            child: Image.network(
              categories.image,
              height: 13.h,
              width: 14.h,
            ),
          )
        ],
      ),
    );
  }
}

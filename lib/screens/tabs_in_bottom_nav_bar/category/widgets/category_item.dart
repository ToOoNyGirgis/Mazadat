import 'package:flutter/material.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/screens/view_item_screen/view_screen.dart';
import 'package:sizer/sizer.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({Key? key, required this.categories}) : super(key: key);
  CategoriesModel categories;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ViewScreen.id,
            arguments: categories);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            child: Card(
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
                    Row()
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: -40,
            child: Image.network(
              categories.image,
              height: 100,
              width: 100,
            ),
          )
        ],
      ),
    );
  }
}

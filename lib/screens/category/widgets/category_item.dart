
import 'package:flutter/material.dart';
import 'package:news_app/screens/view_item_screen/view_screen.dart';
import 'package:sizer/sizer.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,  required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
      child: ListTile(
        onTap: (){
          Navigator.pushNamed(context, ViewScreen.id);
        },
        title: Center(
          child: Text("${index+1}"),
        ),
        tileColor: Colors.amber,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
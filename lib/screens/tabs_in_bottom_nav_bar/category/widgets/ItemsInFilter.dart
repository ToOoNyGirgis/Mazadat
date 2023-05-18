
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/items_model.dart';
import 'package:sizer/sizer.dart';

class ItemsInFilter extends StatelessWidget {
  const ItemsInFilter({
    super.key,
    required this.items,
  });

  final ItemsModel items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
      child: Card(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
          child: ListTile(
            title: Text(items.title),
            onTap: () {},
            leading: Image.network(items.image),
            subtitle:  Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(items.subCategory),
                  Text(
                    DateFormat('dd-MM-yyyy').format(
                      DateTime.parse(items.date),
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
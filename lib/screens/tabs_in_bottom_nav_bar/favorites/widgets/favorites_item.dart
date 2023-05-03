
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FavoritesItem extends StatelessWidget {
  const FavoritesItem({
    super.key,  required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
      child: ListTile(
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
import 'package:flutter/material.dart';
import 'package:news_app/helper/sqldb.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/widgets/category_body.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/widgets/filter_bottom-sheet.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatelessWidget {
  static const String id = 'category';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CategoryBody(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/widgets/category_item.dart';

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
      ),
      body: GridView.builder(
          itemCount: 5,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) => CategoryItem(index: index,)),
    );
  }
}


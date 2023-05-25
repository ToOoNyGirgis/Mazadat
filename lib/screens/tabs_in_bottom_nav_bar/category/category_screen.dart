import 'package:flutter/material.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/widgets/category_body.dart';

class CategoryScreen extends StatelessWidget {
  static const String id = 'category';

  const CategoryScreen({super.key});
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

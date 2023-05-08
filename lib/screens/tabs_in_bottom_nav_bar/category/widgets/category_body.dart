import 'package:flutter/material.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/widgets/category_item.dart';
import 'package:news_app/services/categories.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
      child: FutureBuilder<List<CategoriesModel>>(
        future: CategoriesService().getCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CategoriesModel> categories = snapshot.data!;
            return GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 30,
                ),
                itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: CategoryItem(
                        categories: categories[index],
                      ),
                    ));
          } else if (snapshot.hasError) {
            const Text('Sorry there is an error');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

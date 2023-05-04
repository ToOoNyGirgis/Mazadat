import 'package:flutter/material.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/widgets/category_item.dart';
import 'package:news_app/services/categories.dart';
import 'package:news_app/models/categories_model.dart';


class CategoryScreen extends StatelessWidget{
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
        body: Padding(
          padding: const EdgeInsets.only(top: 50,left: 8,right: 8),
          child: FutureBuilder<List<CategoriesModel>>(
            future: CategoriesService().getCategories(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<CategoriesModel> categories = snapshot.data!;
                return GridView.builder(
                    itemCount: categories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 50,
                    ),
                    itemBuilder: (context, index) => CategoryItem(
                          categories:categories[index] ,
                        ));
              } else if (snapshot.hasError) {
                const Text('Sorry there is an error');
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }

}

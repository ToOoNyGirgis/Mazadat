import 'package:flutter/material.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/filter_screen.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/widgets/category_item.dart';
import 'package:news_app/services/categories.dart';
import 'package:sizer/sizer.dart';

class SubCategories extends StatelessWidget{
  static const String id = 'SubCategories';
  late String categoryName;
  late int categoryId;

  SubCategories({super.key});
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      categoryId = args['categoryId'] as int;
      categoryName = args['categoryName'] as String;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 3.h,),
            Expanded(
              child: FutureBuilder(
                future: CategoriesService().getSub(context, categoryId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CategoriesModel> categories = snapshot.data!;
                    return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 30,
                        ),
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CategoryItem(
                                categories: categories[index],
                                screenNameToNavigate: FilterScreen.id,
                              ),
                            ));
                  } else if (snapshot.hasError) {
                    const Text('Sorry there is an error');
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


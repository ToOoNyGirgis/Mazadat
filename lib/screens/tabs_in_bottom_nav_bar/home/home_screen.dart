import 'package:flutter/material.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/models/items_model.dart';
import 'package:news_app/services/categories.dart';
import 'package:news_app/services/get_item_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoriesModel> categories = [];

  @override
  void initState() {
    super.initState();
    CategoriesService().getCategories(context).then((data) {
      setState(() {
        categories = data;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: categories.length,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('الصفحة الرئيسية'),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              tabs: categories
                  .map((category) => Tab(text: category.name))
                  .toList(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
            child: FutureBuilder<List<ItemsModel>>(
              future: ItemService().getAllCategoryItems(context, 101),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ItemsModel> items = snapshot.data!;
                  return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: items.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 30,
                      ),
                      itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Container(),
                          ));
                } else if (snapshot.hasError) {
                  const Text('Sorry there is an error');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ));
  }
}

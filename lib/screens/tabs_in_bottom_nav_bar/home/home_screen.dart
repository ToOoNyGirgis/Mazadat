import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/models/items_model.dart';
import 'package:news_app/services/categories.dart';
import 'package:news_app/services/get_item_service.dart';
import 'package:sizer/sizer.dart';

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
    checkInternet();
    CategoriesService().getCategories(context).then((data) {
      setState(() {
        categories = data;
      });
    }).catchError((error) {
      print(error);
    });
  }

  bool? internet;
  Future<void> checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      internet = true;
    } else {
      internet = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return internet == true
        ? DefaultTabController(
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
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: double.infinity,
                                        child: Text(
                                          items[index].title,
                                          style: TextStyle(fontSize: 24.sp),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Container(
                                      height: 250.0,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(items[index].image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        items[index].subCategory,
                                        style: TextStyle(fontSize: 24.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                    } else if (snapshot.hasError) {
                      const Text('Sorry there is an error');
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ))
        : const Center(
            child: Text('برجاء التأكد من الاتصال بالأنترنت'),
          );
  }
}

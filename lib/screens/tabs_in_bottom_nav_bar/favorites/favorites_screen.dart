import 'package:flutter/material.dart';
import 'package:news_app/common/constant.dart';
import 'package:news_app/helper/sqldb.dart';
import 'package:news_app/models/items_model.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/widgets/ItemsInFilter.dart';
import 'package:news_app/services/get_item_service.dart';
import 'package:sizer/sizer.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  static String id = 'category';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  SqlDb mySql = SqlDb();

  Future<List<Map>> readData() async {
    List<Map> response = await mySql.readData('SELECT * FROM favorite');
    return response;
  }

  List<ItemsModel> items = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: FutureBuilder(
          future: readData(),
          builder: (context, AsyncSnapshot<List<Map>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                        future: ItemService().filter(context,{
                          'category_id': snapshot.data![index][kCategoryIdDB].toString(),
                          'city_id': snapshot.data![index][kCityIdDB],
                        }),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> FilterSnapshot) {
                          print(FilterSnapshot.data);
                          if (FilterSnapshot.hasData) {

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: FilterSnapshot.data!.length,
                              itemBuilder: (context, filterIndex) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: ItemsInFilter(items: FilterSnapshot.data[filterIndex]),
                                );
                              },
                            );
                          }
                          else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ],
                  );
                },
              );
              // return ListView.builder(
              //     itemCount: snapshot.data!.length,
              //     itemBuilder: (context, index) {
              //       print(snapshot.data![index]['categoryName']);
              //       return FavoritesItem(
              //         category: '${snapshot.data![index][kCategoryNameDB]}',
              //         city: '${snapshot.data![index][kCityNameDB]}',
              //       );
              //
              //     });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      )),
    );
  }
}

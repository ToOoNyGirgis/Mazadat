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
              List<Map<dynamic, dynamic>>? favoritesData = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: favoritesData!.length,
                itemBuilder: (context, index) {
                  print(favoritesData[index][kCityIdDB]);
                  if (favoritesData[index][kCityIdDB]!=null) {
                    return  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'الفئة : ${favoritesData[index][kCategoryNameDB]}',
                          style:
                          const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        favoritesData[index][kCityNameDB] != 'المدينة'
                            ? Text(
                          'المدينة : ${favoritesData[index][kCityNameDB]}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        )
                            : const Text(
                          'لم يتم اختيار مدينة',
                          style:
                          TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // Text(favoritesData[index][kCategoryIdDB]),
                        // Text(favoritesData[index][kCityIdDB]),
                        FutureBuilder(
                          future: ItemService().filter({
                            'category_id': favoritesData[index]
                            [kCategoryIdDB]
                                .toString(),
                            'city_id': favoritesData[index][kCityIdDB],
                          }),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> filterSnapshot) {
                            if (filterSnapshot.hasData) {
                              List<ItemsModel> items = filterSnapshot.data!;
                              return items.length != 0
                                  ? ListView.builder(
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemCount: items.length,
                                itemBuilder: (context, filterIndex) {
                                  return ItemsInFilter(
                                      items: items[filterIndex]);
                                },
                              )
                                  : Text('لا توجد بيانات');
                            } else if (filterSnapshot.hasError) {
                              return Text('حدث خطأ');
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                      ],
                    );
                  }
                  else{
                    return  Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'الفئة : ${favoritesData[index][kCategoryNameDB]}',
                            style:
                            const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          favoritesData[index][kCityNameDB] != 'المدينة'
                              ? Text(
                            'المدينة : ${favoritesData[index][kCityNameDB]}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          )
                              : const Text(
                            'لم يتم اختيار مدينة',
                            style:
                            TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // Text(favoritesData[index][kCategoryIdDB]),
                          // Text(favoritesData[index][kCityIdDB]),
                          FutureBuilder(
                            future: ItemService().filter({
                              'category_id': favoritesData[index]
                              [kCategoryIdDB]
                                  .toString(),
                            }),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> filterSnapshot) {
                              if (filterSnapshot.hasData) {
                                List<ItemsModel> items = filterSnapshot.data!;
                                return items.length != 0
                                    ? ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  itemCount: items.length,
                                  itemBuilder: (context, filterIndex) {
                                    return ItemsInFilter(
                                        items: items[filterIndex]);
                                  },
                                )
                                    : Text('لا توجد بيانات');
                              } else if (filterSnapshot.hasError) {
                                return Text('حدث خطأ');
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
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

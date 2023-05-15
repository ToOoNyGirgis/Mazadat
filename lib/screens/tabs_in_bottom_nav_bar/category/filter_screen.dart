import 'package:flutter/material.dart';
import 'package:news_app/common/constant.dart';
import 'package:news_app/helper/sqldb.dart';
import 'package:news_app/models/items_model.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/widgets/ItemsInFilter.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/widgets/filter_bottom-sheet.dart';
import 'package:news_app/services/get_item_service.dart';
import 'package:sizer/sizer.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);
  static const String id = 'filter';

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late String selectedCityName;
  late String categoryName;
  late int categoryId;
  bool isCitySelected = false;
  IconData starIcon = Icons.star_border;
  Color starIconColor = Colors.black;
  int? selectedCityId;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    selectedCityName = 'المدينة';
    selectedCityId = null;
  }

  SqlDb sqlDb = SqlDb();
  Future<List<Map>> readDate() async {
    List<Map> response = await sqlDb.readData('SELECT * FROM favorite');
    return response;
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final result = await showModalBottomSheet(
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (context) => const FilterBottomSheet(),
                        );
                        if (result != null) {
                          setState(() {
                            selectedCityName = result['name']!;
                            selectedCityId = result['id']!;
                            starIcon = Icons.star_border;
                            starIconColor = Colors.black;
                            isCitySelected = true;
                          });
                        }
                      },
                      icon: const Icon(Icons.sort),
                    ),
                    Text(selectedCityName),
                  ],
                ),
                FutureBuilder(
                  future: sqlDb.readDataWithWhere(categoryId, selectedCityId , selectedCityName),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map>> snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      if (data.isNotEmpty) {
                        isPressed = true;
                        starIcon = Icons.star;
                        starIconColor = Colors.orangeAccent;
                      } else {
                        isPressed = false;
                        starIcon = Icons.star_border;
                        starIconColor = Colors.black;
                      }
                      return IconButton(
                        onPressed: isPressed == false
                            ? () async {
                          int response = await sqlDb.insertData(
                              'INSERT INTO "favorite" ($kCityIdDB, $kCityNameDB, $kCategoryIdDB, $kCategoryNameDB) VALUES("$selectedCityId", "$selectedCityName", "$categoryId", "$categoryName")');
                          if (response > 0) {
                            setState(() {
                              starIcon = Icons.star;
                              starIconColor = Colors.orangeAccent;
                              isPressed = true;
                            });
                          }
                        }
                            : () async {
                          if (selectedCityId == null) {
                            int response = await sqlDb.deleteData(
                                'DELETE FROM "favorite" WHERE "$kCityNameDB" = "$selectedCityName"');
                            if (response > 0) {
                              setState(() {
                                starIcon = Icons.star_border;
                                starIconColor = Colors.black;
                                isPressed = false;
                              });
                            }
                          } else {

                            int response = await sqlDb.deleteData(
                                'DELETE FROM "favorite" WHERE "$kCategoryIdDB" = "$categoryId" AND "$kCityIdDB" = "$selectedCityId"');
                            if (response > 0) {
                              setState(() {
                                starIcon = Icons.star_border;
                                starIconColor = Colors.black;
                                isPressed = false;
                              });
                            }
                          }
                        },
                        icon: Icon(
                          starIcon,
                          color: starIconColor,
                          size: 22.sp,
                        ),
                      );
                    }
                    return IconButton(
                      onPressed: () async {
                        int response = await sqlDb.insertData(
                            'INSERT INTO "favorite" ($kCityIdDB, $kCityNameDB, $kCategoryIdDB, $kCategoryNameDB) VALUES("$selectedCityId", "$selectedCityName", "$categoryId", "$categoryName")');
                        if (response > 0) {
                          setState(() {
                            starIcon = Icons.star_border;
                            starIconColor = Colors.black;
                            isPressed = true;
                          });
                        }
                      },
                      icon: Icon(
                        starIcon,
                        color: starIconColor,
                        size: 22.sp,
                      ),
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: ItemService().filter(context, {
                  'category_id': categoryId.toString(),
                  'city_id': selectedCityId,
                }),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ItemsModel> items = snapshot.data!;
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ItemsInFilter(items: items[index]),
                        ));
                  } else if (snapshot.hasError) {
                    const Text('Sorry there is an error');
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


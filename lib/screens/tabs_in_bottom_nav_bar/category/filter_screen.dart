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
  final controller = ScrollController();
  int page = 0;
  bool hasMore = true;
  bool _isLoading = false;
  List<ItemsModel> items = [];

  @override
  void initState() {
    super.initState();
    selectedCityName = 'المدينة';
    selectedCityId = null;
    controller.addListener(() {
      if(controller.position.maxScrollExtent==controller.offset){
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    if(_isLoading)return;
    _isLoading = true;
    const limit = 25;
    final newItems = await ItemService().filter(
        {
      'category_id': categoryId.toString(),
      'city_id': selectedCityId,
      'page': page,
      'limit': limit,
    }
    );
    setState(() {
      page++;
      _isLoading=false;
      if (newItems.length<limit) {
        hasMore = false;
      }
      items.addAll(newItems);
    });
  }

  SqlDb sqlDb = SqlDb();
  Future<List<Map>> readDate() async {
    List<Map> response = await sqlDb.readData('SELECT * FROM favorite');
    return response;
  }

  Future<void>refresh()async{
    setState(() {

      _isLoading=false;
      hasMore=true;
      page=0;
      items.clear();
    });
    fetchData();
  }


  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      categoryId = args['categoryId'] as int;
      categoryName = args['categoryName'] as String;
      fetchData();
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
                  future: sqlDb.readDataWithWhere(
                      categoryId, selectedCityId, selectedCityName),
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
              child: RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length + 1,
                  itemBuilder: (context, index) {
                    if (index < items.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ItemsInFilter(items: items[index]),
                      );
                    } else {
                      return Center(
                        child: hasMore
                            ? CircularProgressIndicator()
                            : Text('No more data to show'),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

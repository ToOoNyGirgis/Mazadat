import 'package:flutter/material.dart';
import 'package:news_app/helper/sqldb.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/widgets/filter_bottom-sheet.dart';
import 'package:sizer/sizer.dart';

class SubCategories extends StatefulWidget {
  const SubCategories({Key? key}) : super(key: key);
  static const String id = 'SubCategories';

  @override
  State<SubCategories> createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  late String selectedCityName;
  late String categoryName;
  late int categoryId;
  IconData starIcon=Icons.star_border;
  Color starIconColor =Colors.black;
  int? selectedCityId;

  @override
  void initState() {
    super.initState();
    selectedCityName = 'المدينة';
  }

  SqlDb sqlDb = SqlDb();

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
                            starIcon=Icons.star_border;
                            starIconColor =Colors.black;
                          });
                        }
                      },
                      icon: const Icon(Icons.sort),
                    ),
                    Text(selectedCityName),
                  ],
                ),
                IconButton(
                  onPressed: () async {
                    int response = await sqlDb.insertData(
                        'INSERT INTO "favorite" (cityId, categoryId) VALUES("$selectedCityId", "$categoryId")');
                    print(response);
                    if(response>0){
                      starIcon=Icons.star;
                      starIconColor =Colors.orangeAccent;
                      setState(() {

                      });
                    }
                  },
                  icon: Icon(
                    starIcon,
                    color: starIconColor,
                    size: 22.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/widgets/category_body.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/category/widgets/filter_bottom-sheet.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  static String id = 'category';

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late String selectedCityName;

  @override
  void initState() {
    super.initState();
    selectedCityName = 'المدينة'; // default city name
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('الصفحة الرئيسية'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () async {
                  final name = await showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (context) => const FilterBottomSheet(),
                  );
                  if (name != null) {
                    setState(() {
                      selectedCityName = name;
                    });
                  }
                },
                icon: Icon(Icons.sort),
              ),
              Text(selectedCityName),
            ],
          ),
          Expanded(
            child: CategoryBody(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_app/common/constant.dart';
import 'package:news_app/helper/sqldb.dart';
import 'package:news_app/screens/tabs_in_bottom_nav_bar/favorites/widgets/favorites_item.dart';
import 'package:news_app/widgets/custom_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: CustomButton(text: 'text',onTap: () async {
        //     await mySql.deleteTable('favorite');
        //     print('deleted');
        //   },),
        // ),
          body: FutureBuilder(
        future: readData(),
        builder: (context, AsyncSnapshot<List<Map>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                // print(snapshot.data![index]['categoryName']);
               return FavoritesItem(
                  category: '${snapshot.data![index]['$kCategoryNameDB']}',
                  city: '${snapshot.data![index]['$kCityNameDB']}',
                );
              }
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}

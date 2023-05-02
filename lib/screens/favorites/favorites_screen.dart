import 'package:flutter/material.dart';
import 'package:news_app/screens/favorites/widgets/favorites_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  static String id = 'category';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('الصفحة الرئيسية'),
        centerTitle: true,
      ),
      body: GridView.builder(
          itemCount: 5,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) => FavoritesItem(index: index,)),
    );
  }
}


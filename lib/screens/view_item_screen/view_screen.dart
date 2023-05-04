import 'package:flutter/material.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/screens/view_item_screen/widgets/view_screen_body.dart';

class ViewScreen extends StatelessWidget {
  ViewScreen({Key? key}) : super(key: key);
  static String id = 'ViewScreen';
  @override
  Widget build(BuildContext context) {
    CategoriesModel categories =
        ModalRoute.of(context)?.settings.arguments as CategoriesModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: const ViewScreenBody(),
    );
  }
}

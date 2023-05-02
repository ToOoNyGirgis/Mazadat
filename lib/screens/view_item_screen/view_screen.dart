import 'package:flutter/material.dart';
import 'package:news_app/screens/view_item_screen/widgets/view_screen_body.dart';
import 'package:sizer/sizer.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({Key? key}) : super(key: key);
  static String id = 'ViewScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اسم المنتج'),
      ),
      body: ViewScreenBody(),
    );
  }
}

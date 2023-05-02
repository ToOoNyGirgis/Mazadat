import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  static String id = 'category';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('الصفحة الرئيسية'),
        centerTitle: true,
      ),
      body: GridView.builder(
          itemCount: 5,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                child: ListTile(
                  title: Center(
                    child: Text('${index+1}'),
                  ),
                  tileColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              )),
    );
  }
}

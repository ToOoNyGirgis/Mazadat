
import 'package:flutter/material.dart';
import 'package:news_app/models/items_model.dart';
import 'package:sizer/sizer.dart';

class ItemsInFilter extends StatelessWidget {
  const ItemsInFilter({
    super.key,
    required this.items,
  });

  final ItemsModel items;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(items.title),
      onTap: () {},
      leading: Image.network(items.image),
      subtitle: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Text(
          items.desc,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
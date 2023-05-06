class ItemsModel {
  final int id;
  final String title;
  final String desc;
  final String date;
  final String time;
  final String mobile;
  // final String city;
  final String cityId;
  final String category;
  final String categoryId;
  final String subId;
  final String subCategory;
  final String image;
  // final List<String> images;

  ItemsModel({
    required this.desc,
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.mobile,
    // required this.city,
    required this.cityId,
    required this.category,
    required this.categoryId,
    required this.subId,
    required this.subCategory,
    required this.image,
    // required this.images,
  });

  factory ItemsModel.fromJson(jsonData) {
    return ItemsModel(
      id: jsonData['id'],
      title: jsonData['title'],
      image: jsonData['image'],
      category: jsonData['category'],
      date: jsonData['date'],
      // city: jsonData['city'],
      mobile: jsonData['mobile'],
      subCategory: jsonData['sub_category'],
      time: jsonData['time'],
      // images: jsonData['images'],
      cityId: jsonData['city_id'],
      categoryId: jsonData['category_id'],
      subId: jsonData['sub_id'],
      desc: jsonData['desc'],
    );
  }
}

class ItemsModel {
  final int id;
  final String title;
  final String date;
  final DateTime time;
  final String mobile;
  final String city;
  final String category;
  final String subCategory;
  final String image;
  final List<String> images;

  ItemsModel({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.mobile,
    required this.city,
    required this.category,
    required this.subCategory,
    required this.image,
    required this.images,
  });
}

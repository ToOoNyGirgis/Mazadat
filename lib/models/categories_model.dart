class CategoriesModel {
  final int id;
  final String name;
  final String image;

  CategoriesModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoriesModel.fromJson(jsonData) {
    return CategoriesModel(
      id: jsonData['id'],
      name: jsonData['name'],
      image: jsonData['image'],
    );
  }
}

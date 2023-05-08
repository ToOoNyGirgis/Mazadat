class CitiesModel {
  final int id;
  final String name;

  CitiesModel({
    required this.id,
    required this.name,
  });

  factory CitiesModel.fromJson(jsonData) {
    return CitiesModel(
      id: jsonData['id'],
      name: jsonData['name'],
    );
  }
}

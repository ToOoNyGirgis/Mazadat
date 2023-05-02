class UserModel {
  final int id;
  final String name;
  final String last_name;
  final String mobile;
  final String image;

  UserModel({
    required this.id,
    required this.name,
    required this.last_name,
    required this.mobile,
    required this.image,
  });

  factory UserModel.fromJson(jsonData) {
    return UserModel(
      id: jsonData['id'],
      name: jsonData['name'],
      image: jsonData['image'],
      last_name: jsonData['last_name'],
      mobile: jsonData['mobile'],
    );
  }
}

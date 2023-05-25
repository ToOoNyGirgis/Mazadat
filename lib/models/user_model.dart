class UserModel {
  final int id;
  final String name;
  final String lastName;
  final String mobile;
  // final String password;
  // final String image;

  UserModel({
    // required this.password,
    required this.id,
    required this.name,
    required this.lastName,
    required this.mobile,
    // required this.image,
  });

  factory UserModel.fromJson(jsonData) {
    return UserModel(
      id: jsonData['id'],
      name: jsonData['name'],
      // image: jsonData['image'],
      lastName: jsonData['last_name'],
      mobile: jsonData['mobile'],
      // password: jsonData['password'],
    );
  }
}

import 'package:news_app/helper/api.dart';

//
class LoginService {
//   final api = Api();
//
//   final phone = '01200000000';
//   final password = 'password123';
//
//   Future<dynamic> postLogin() async {
//     final data = await api.postLogin(phone: phone, password: password);
// // save the user's data in shared preferences or secure storage
//   }
  final api = Api();
  Future<Map<String, dynamic>> postLogin(
      {required String phone, required String password}) async {
    final url = 'https://example.com/login';
    final body = {'phone': phone, 'password': password};
    try {
      final response = await api.post(url: url, body: body);
      final data = response['data'];
      return data;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}

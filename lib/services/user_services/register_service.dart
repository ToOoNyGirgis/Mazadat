import 'package:news_app/helper/api.dart';

class RegisterService{

  Future<Map<String, dynamic>> postRegister({
    required String name,
    required String phone,
    required String password,
  }) async {
    final api = Api();
    final url = 'https://example.com/register';
    final body = {'name': name, 'phone': phone, 'password': password};

    try {
      final response = await api.post(url: url, body: body);
      final data = response['data'];
      return data;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

}
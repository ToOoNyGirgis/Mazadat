import 'package:news_app/helper/api.dart';

class RegisterService{
  static const _kApiUrl = 'https://mazadat.bluesoftec.net/api/register/';

  Future<Map<String, dynamic>> postRegister({
    required String name,
    required String phone,
    required String password,
  }) async {
    final api = Api();
    final body = {'name': name, 'phone': phone, 'password': password};

    try {
      final response = await api.post(url: _kApiUrl, body: body);
      final data = response['data'];
      return data;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

}
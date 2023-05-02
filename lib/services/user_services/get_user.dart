import 'package:news_app/helper/api.dart';

class GetUserService {
  Future<Map<String, dynamic>> getUser(
      {required String id, required String token}) async {
    final api = Api(); // create an instance of the Api class
    final url = 'https://example.com/user/$id';
    final headers = {'Authorization': 'Bearer $token'};

    try {
      final response = await api.get(url: url);
      final data = response['data'];
      return data;
    } catch (e) {
      throw Exception('Failed to get user data: $e');
    }
  }
}

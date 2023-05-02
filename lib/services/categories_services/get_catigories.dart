import 'package:news_app/helper/api.dart';

class CategoriesService {
  Future<List<dynamic>> getCategories() async {
    List<dynamic> data =
    await Api().get(url: '');
    return data;
  }
}

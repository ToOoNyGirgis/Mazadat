import 'package:news_app/helper/api.dart';
import 'package:news_app/models/categories_model.dart';

class CategoriesService {
  Future<List<CategoriesModel>> getCategories() async {
    List<dynamic> data =
    await Api().get(url: 'https://example.com/api/categories');
    List<CategoriesModel> CategoriesList = [];
    for (int i = 0; i < data.length; i++) {
      CategoriesList.add(
        CategoriesModel.fromJson(data[i]),
      );
    }
    return CategoriesList;
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/models/items_model.dart';
import 'package:news_app/services/categories.dart';
import 'package:news_app/services/get_item_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._categoriesService, this._itemService) : super(HomeInitial());
  final CategoriesService _categoriesService;
  final ItemService _itemService;
  late TabController _tabController;
  late List<CategoriesModel> categories;
  bool? _internet;

  Future<void> loadHomeData() async {
    emit(HomeLoading());
    try {
      await checkInternet();
      categories = await _categoriesService.getCategories();
      List<ItemsModel> items = await _itemService.filter({
        'category_id':categories[11].id
      });
      emit(HomeSuccess(items: items, category: categories));
    } catch (error) {
      if (_internet == false) {
        emit(HomeNoInternet());
      } else {
        emit(HomeFailure(errMessage: error.toString()));
      }
    }
  }

  Future<void> checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      _internet = true;
    } else {
      _internet = false;
    }
  }
}

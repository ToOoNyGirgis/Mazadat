import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/services/categories.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._categoriesService) : super(HomeInitial());
  final CategoriesService _categoriesService;
  late List<CategoriesModel> categories;
  bool? _internet;

  Future<void> loadHomeData() async {
    emit(HomeLoading());
    try {
      await checkInternet();
      categories = await _categoriesService.getCategories();
      emit(HomeSuccess( category: categories));
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

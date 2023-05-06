part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeNoInternet extends HomeState {}

class HomeSuccess extends HomeState {
  List<ItemsModel> items;
  List<CategoriesModel> category;
  HomeSuccess({
    required this.items,
    required this.category,
  });
}

class HomeFailure extends HomeState {
  String errMessage;
  HomeFailure({required this.errMessage});
}

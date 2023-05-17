part of 'home_body_cubit.dart';

@immutable
abstract class HomeBodyState {}

class HomeBodyInitial extends HomeBodyState {}
class HomeBodyLoading extends HomeBodyState {}
class HomeBodyNoInternet extends HomeBodyState {}
class HomeBodySuccess extends HomeBodyState {
  List<ItemsModel> items;

  HomeBodySuccess({
    required this.items,
  });
}
class HomeBodyFailure extends HomeBodyState {
  String errMessage;
  HomeBodyFailure({required this.errMessage});
}


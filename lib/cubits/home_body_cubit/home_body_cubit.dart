import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:news_app/models/categories_model.dart';
import 'package:news_app/models/items_model.dart';
import 'package:news_app/services/get_item_service.dart';

part 'home_body_state.dart';

class HomeBodyCubit extends Cubit<HomeBodyState> {
  HomeBodyCubit(this._itemService) : super(HomeBodyInitial());
  bool? _internet;
  final ItemService _itemService;

  Future<void> checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      _internet = true;
    } else {
      _internet = false;
    }
  }

  Future<void> getDataForEachTab( int category) async {
    emit(HomeBodyLoading());
    try {
      await checkInternet();
      print(category);
      List<ItemsModel> items = await _itemService.filter({
        'category_id':category.toString()
      });
      emit(HomeBodySuccess(items: items));
    } catch (error) {
      if (_internet == false) {
        emit(HomeBodyNoInternet());
      } else {
        emit(HomeBodyFailure(errMessage: error.toString()));
      }
    }
  }

}

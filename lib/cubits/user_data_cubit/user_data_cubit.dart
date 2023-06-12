import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/services/get_user.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());


  void fetchData(){
    emit(UserDataSuccess());
  }
}

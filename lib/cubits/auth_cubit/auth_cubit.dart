import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/services/get_user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> registerUser(
      {required String mobile,
      required String name,
      required String lastName,
      required String password}) async {
    emit(RegisterLoading());
    try {
      if (await GetUserService().register({
            'name': name,
            'last_name': lastName,
            'mobile': mobile,
            'password': password,
          }) ==
          true) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure(errMessage: 'لقد حدث خطأ'));
      }
    } on Exception catch (e) {
      emit(RegisterFailure(errMessage: 'something went wrong'));
    }
  }

  Future<void> loginUser(
      {required String mobile, required String password}) async {
    emit(LoginLoading());
    try {
      if (await GetUserService().login({
            'mobile': mobile,
            'password': password,
          }) ==
          true) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(errMessage: 'تأكد من رقم الهاتف او الرقم السري'));
      }
    } on Exception catch (e) {
      emit(LoginFailure(errMessage: 'something went wrong'));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/common/constant.dart';
import 'package:news_app/services/get_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final GoogleSignIn googleSignIn =GoogleSignIn();
  // final FacebookAuth facebookLogin= FacebookAuth();


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
      emit(RegisterFailure(errMessage: 'something went wrong: $e'));
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
      emit(LoginFailure(errMessage: 'something went wrong: $e'));
    }
  }


  Future<void> loginWithGoogle() async{
    try {
      emit(LoginLoading());
      googleSignIn.signIn().then((value) async {
        String? name = value!.id;
        print('id is $name');
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString(kAccessTokenInPref, value.id);
        pref.setString(kAccessMethod, "Google");
        emit(LoginSuccess());
      });

    } on Exception catch (e) {
  emit(LoginFailure(errMessage: 'something went wrong: $e'));
  }

  }
}

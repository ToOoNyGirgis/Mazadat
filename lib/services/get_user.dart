import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/common/constant.dart';
import 'package:news_app/helper/api.dart';
import 'package:news_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserService {
  late Map<String, String> requestHeaders;
  static const _kApiUrl = 'https://mazadat.bluesoftec.net/api/users/';

  get_headers(String token) async {

    return requestHeaders = {
      'Content-type': 'application/json',
      'token': token
    };
  }

  Future<List<UserModel>> getUser(BuildContext context) async {
    try {
      SharedPreferences pref =await SharedPreferences.getInstance();
      String? token= pref.getString(kAccessTokenInPref);
      print(token);
      http.Response response = await http.get(Uri.parse('https://mazadat.bluesoftec.net/api/users/getUser'),
          headers: await get_headers(token!));


      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        throw Exception(data['error']['message']);
      }
      final items = json.decode(response.body)['data'] as List?;
      List<UserModel> list =
          items!.map((val) => UserModel.fromJson(val)).toList();
      // print(list);
      return list;
    } on SocketException {
      throw Exception('No Internet connection 😑');
    } on HttpException {
      throw Exception("Couldn't find the post 😱");
    } on FormatException {
      throw Exception("Bad response format 👎");
    }
  }

  Future<bool> login(data) async {
    final api = Api();
    try {
      final response = await api.post(
        url: '${_kApiUrl}login',
        headers: await get_headers('token'),
        body: json.encode(data),
      );
      if (response['status'] == true) {
        // store token in sharedPreference
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString(kAccessTokenInPref, response['data']);
        // pref.setString(kAccessMethod, 'API');
        return true;
      } else {
        // show the response['message']
        return false;
      }
    } on SocketException {
      throw Exception('No Internet connection 😑');
    } on HttpException {
      throw Exception("Couldn't find the post 😱");
    } on FormatException {
      throw Exception("Bad response format 👎");
    }
  }

  Future<bool> register(data) async {
    final api = Api();
    final response = await api.post(
      url: '${_kApiUrl}register',
      headers: await get_headers('token'),
      body: json.encode(data),
    );
    if (response['status'] == true) {
      // store token in sharedPreference
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString(kAccessTokenInPref, response['data']);

      return true;
    } else {
      // show the response['message']
      return false;
    }
  }
}

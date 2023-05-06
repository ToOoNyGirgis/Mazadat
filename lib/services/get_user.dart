import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/helper/api.dart';
import 'package:news_app/models/user_model.dart';

class GetUserService {
  late Map<String, String> requestHeaders;
  static const _kApiUrl = 'https://mazadat.bluesoftec.net/api/users/';

  get_headers(BuildContext context) async {
    return requestHeaders = {
      'Content-type': 'application/json',
      'lang': context.locale.toString(),
      'token': "token"
    };
  }

  Future<List<UserModel>> getUser(BuildContext context, String userId) async {
    try {
      http.Response response = await http.get(Uri.parse(_kApiUrl + userId),
          headers: await get_headers(context));

      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        throw Exception(data['error']['message']);
      }
      final items = json.decode(response.body)['data'] as List?;
      List<UserModel> list =
          items!.map((val) => UserModel.fromJson(val)).toList();

      return list;
    } on SocketException {
      throw Exception('No Internet connection 😑');
    } on HttpException {
      throw Exception("Couldn't find the post 😱");
    } on FormatException {
      throw Exception("Bad response format 👎");
    }
  }

  Future<bool> login(BuildContext context, data) async {
    final api = Api();
    try {
      final response = await api.post(
        url: '${_kApiUrl}login/',
        headers: await get_headers(context),
        body: json.encode(data),
      );
      if (response['status'] == true) {
        // store token in sharedPreference
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

  Future<bool> register(BuildContext context, data) async {
    final api = Api();
    final response = await api.post(
      url: '${_kApiUrl}register/',
      headers: await get_headers(context),
      body: json.encode(data),
    );
    if (response['status'] == true) {
      // store token in sharedPreference
      return true;
    } else {
      // show the response['message']
      return false;
    }
  }
}

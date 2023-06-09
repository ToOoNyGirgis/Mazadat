import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/items_model.dart';

class FavoriteService {
  late Map<String, String> requestHeaders;

  static const _kApiUrl = 'https://mazadat.bluesoftec.net/api/favorites/';

  get_headers(BuildContext context) async {
    return requestHeaders = {
      'Content-type': 'application/json',
      'lang': context.locale.toString(),
      'token': "token"
    };
  }

  Future<List<ItemsModel>> getFavorites(BuildContext context) async {
    try {
      http.Response response = await http.get(Uri.parse(_kApiUrl + 'getAll'),
          headers: await get_headers(context));

      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        throw Exception(data['error']['message']);
      }
      final items = json.decode(response.body)['data'] as List?;
      List<ItemsModel> list =
      items!.map((val) => ItemsModel.fromJson(val)).toList();

      return list;
    } on SocketException {
      throw Exception('No Internet connection 😑');
    } on HttpException {
      throw Exception("Couldn't find the post 😱");
    } on FormatException {
      throw Exception("Bad response format 👎");
    }
  }
}

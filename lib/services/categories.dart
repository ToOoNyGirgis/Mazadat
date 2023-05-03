import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:http/http.dart' as http;
import '/models/categories_model.dart';

class CategoriesService {
  late Map<String, String> requestHeaders;

  static const _kApiUrl = 'https://mazadat.bluesoftec.net/api/categories/';

  get_headers(BuildContext context) async {
    return requestHeaders = {
      'Content-type': 'application/json',
      'lang': context.locale.toString(),
      'token': "token"
    };
  }

  Future<List<CategoriesModel>> getCategories(BuildContext context) async {
    http.Response response = await http.get(Uri.parse(_kApiUrl + 'getAll'),
        headers: await get_headers(context));

    if (response.statusCode != 200) {
      var data = jsonDecode(response.body);
      throw Exception(data['error']['message']);
    }
    final items = json.decode(response.body)['data'] as List?;
    List<CategoriesModel> list =
        items!.map((val) => CategoriesModel.fromJson(val)).toList();

    return list;
  }
}

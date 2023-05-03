import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> get({
    required String url,
    @required String? token,

  }) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': "Bearer $token"});
    }
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'there\'s an error in status code = ${response.statusCode} \n and the body is : \n ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> post(
      {required String url,
      @required dynamic body,
      @required dynamic headers,
      @required String? token}) async {

    if (token != null) {
      headers.addAll({'Authorization': "Bearer $token"});
    }
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'there\'s an error in status code = ${response.statusCode} \n and the body is : \n ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> put(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (token != null) {
      headers.addAll({'Authorization': "Bearer $token"});
    }
    http.Response response = await http.put(
      Uri.parse(url),
      body: body,
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'there\'s an error in status code = ${response.statusCode} \n and the body is : \n ${jsonDecode(response.body)}');
    }
  }
}

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
//
// import 'package:http/http.dart' as http;
// import 'package:needs_merchant/models/product_model.dart';
// import 'package:provider/provider.dart';
//
// import '../models/user_model.dart';
// import '../services/api.dart';
// import '../widgets/dialog.dart';
// import 'auth.dart';
//
// class UserService with ChangeNotifier {
//   late Map<String, String> requestHeaders;
//
//   get_headers(BuildContext context) async {
//     final token = await context.read<Auth>().getToken();
//     return requestHeaders = {
//       'Content-type': 'application/json',
//       'lang': context.locale.toString(),
//       'token': token.toString()
//     };
//   }
//
//   Future<bool> logIn(BuildContext context, data) async {
//     http.Response response = await http.post(Uri.parse(API.login),
//         body: json.encode(data), headers: await get_headers(context));
//     if (response.statusCode != 200) {
//       var data = jsonDecode(response.body);
//       throw Exception(data['error']['message']);
//     }
//     final parsedList = json.decode(response.body);
//     if (parsedList['status'] == true) {
//       notifyListeners();
//       context.read<Auth>().setToken(parsedList['data']);
//       // await DialogsService.basicInfo(context, parsedList['message']);
//       return true;
//     } else {
//       await DialogsService.basicInfo(context, parsedList['message']);
//       return false;
//     }
//   }
//
//   Future<bool> register(BuildContext context, data) async {
//     http.Response response = await http.post(Uri.parse(API.register),
//         body: json.encode(data), headers: await get_headers(context));
//     if (response.statusCode != 200) {
//       var data = jsonDecode(response.body);
//       throw Exception(data['error']['message']);
//     }
//     final parsedList = json.decode(response.body);
//     if (parsedList['status'] == true) {
//       notifyListeners();
//       await DialogsService.basicInfo(context, parsedList['message']);
//       return true;
//     } else {
//       await DialogsService.basicInfo(context, parsedList['message']);
//       return false;
//     }
//     // return false;
//   }
//
//   Future<UserModel> getUser(BuildContext context) async {
//     http.Response response = await http.get(Uri.parse(API.getUser),
//         headers: await get_headers(context));
//     if (response.statusCode != 200) {
//       var data = jsonDecode(response.body);
//       throw Exception(data['error']['message']);
//     }
//     final parsedList = json.decode(response.body)['data'][0];
//     UserModel user = UserModel.fromJson(parsedList);
//     return user;
//   }
//
//   Future<bool> update(BuildContext context, data) async {
//     http.Response response = await http.post(Uri.parse(API.update),
//         body: json.encode(data), headers: await get_headers(context));
//     if (response.statusCode != 200) {
//       var data = jsonDecode(response.body);
//       throw Exception(data['error']['message']);
//     }
//     final parsedList = json.decode(response.body);
//     if (parsedList['status'] == true) {
//       notifyListeners();
//       return true;
//     }
//     return false;
//   }
// }

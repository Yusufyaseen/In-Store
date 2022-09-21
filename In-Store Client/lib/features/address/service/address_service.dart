import 'dart:convert';

import 'package:amazon_cloning/constants/error_handling.dart';
import 'package:amazon_cloning/constants/global_variables.dart';
import 'package:amazon_cloning/features/controllers/user_controller.dart';
import 'package:amazon_cloning/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../constants/utils.dart';

class AddressService{
  final UserController userController = Get.put(UserController());
  String? url = dotenv.get("SERVER_URL");
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {


    try {
      http.Response res = await http.post(
        Uri.parse('$url/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userController.user.token,
        },
        body: json.encode({
          'address': address,
        }),
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          UserModel user = userController.user.copyWith(
            address: jsonDecode(res.body)['data']['address'],
          );

          userController.setUserModelByObject(user);
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {

    try {
      http.Response res = await http.post(Uri.parse('$url/user/api/place-order'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': userController.user.token,
          },
          body: json.encode({
            'cart': userController.user.cart,
            'address': address,
            'totalPrice': totalSum,
          }));

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {

          UserModel user = userController.user.copyWith(
            cart: [],
          );
          userController.setUserModelByObject(user);
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

}
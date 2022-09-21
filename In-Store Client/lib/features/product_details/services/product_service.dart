import 'dart:convert';

import 'package:amazon_cloning/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../constants/error_handling.dart';
import '../../controllers/user_controller.dart';

class ProductDetailsService {
  String? url = dotenv.get("SERVER_URL");

  UserController userController = Get.put(UserController());

  void addToCart({
    required BuildContext context,
    required String id,
  }) async {
    try {
      http.Response response = await http.post(
          Uri.parse("$url/user/api/add-product"),
          body: json.encode({'id': id}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': userController.user.token,
          });
      httpErrorHandling(onSuccess: () {
        UserModel userModel = userController.user.copyWith(cart: json.decode(response.body)['data']['cart']);
        userController.setUserModelByObject(userModel);
      }, context: context, response: response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void rateProduct(
      {required BuildContext context,
      required String id,
      required double rating}) async {
    try {
      http.Response response = await http.post(
          Uri.parse("$url/products/api/rate-product"),
          body: json.encode({'id': id, 'rating': rating}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': userController.user.token,
          });

      httpErrorHandling(onSuccess: () {}, context: context, response: response);
    } catch (e) {}
  }
}

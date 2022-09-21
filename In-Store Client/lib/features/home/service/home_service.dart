import 'dart:convert';

import 'package:amazon_cloning/constants/error_handling.dart';
import 'package:amazon_cloning/features/controllers/products_controller.dart';
import 'package:amazon_cloning/features/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../constants/utils.dart';
import '../../../models/product.dart';

class HomeService{
  String? url = dotenv.get("SERVER_URL");
  ProductsController productsController = Get.put(ProductsController());
  Future<void> fetchDealOfDay({
    required BuildContext context,
  }) async {
    UserController userController = Get.put(UserController());

    try {
      http.Response res =
      await http.get(Uri.parse('$url/products/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': userController.user.token,
      });
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiii\n");
          print(json.decode(res.body)['data']);
          productsController.setDealOfDay(Product.fromMap(json.decode(res.body)['data']));
        },
      );
    } catch (e) {
      // showSnackBar(context, e.toString());
    }
  }
}
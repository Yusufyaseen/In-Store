import 'dart:convert';

import 'package:amazon_cloning/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../controllers/products_controller.dart';
class SearchService{
  String? url = dotenv.get("SERVER_URL");
  ProductsController productsController = Get.put(ProductsController());
  Future<void> fetchProducts({
    required BuildContext context,
    required String query,
  }) async {
    List<Product> products = [];
    try {

      http.Response response = await http.get(
          Uri.parse('$url/products/search/$query'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () async {

            List list = json.decode(response.body)["data"];
            debugPrint("----" + list.toString());
            productsController.setProductsBySearch(list);
          });

    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
import 'dart:convert';

import 'package:amazon_cloning/constants/error_handling.dart';
import 'package:amazon_cloning/features/controllers/user_controller.dart';
import 'package:amazon_cloning/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartServices {
  String? url = dotenv.get("SERVER_URL");
  void removeFromCart({
    required BuildContext context,
    required String id,
  }) async {
    UserController userController = Get.put(UserController());

    try {
      http.Response res = await http.delete(
        Uri.parse('$url/user/api/remove-from-cart/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userController.user.token,
        },
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          print("----"  + res.body.toString());
          UserModel userModel = userController.user.copyWith(cart: json.decode(res.body)['data']['cart']);
          print("0000${userModel.name}");
          print("0000${userModel.cart}");
          userController.setUserModelByObject(userModel);
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
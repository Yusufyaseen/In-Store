import 'dart:convert';

import 'package:amazon_cloning/constants/error_handling.dart';
import 'package:amazon_cloning/features/controllers/order_controller.dart';
import 'package:amazon_cloning/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../models/order.dart';
import '../../auth/screens/auth_screen.dart';
import '../../controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
class AccountService {
  final UserController userController = Get.put(UserController());
  final OrderController orderController = Get.put(OrderController());
  String? url = dotenv.get("SERVER_URL");
  static final box = GetStorage();
  Future<void> fetchMyOrders({
    required BuildContext context,
  }) async {
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$url/user/api/orders/me'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userController.user.token,
        },
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          List data = json.decode(res.body)['data'];
          orderList = data.map((order) => Order.fromMap(order)).toList();
          orderController.setOrders(orderList);
          // for (int i = 0; i < json.decode(res.body)['data'].length; i++) {
          //   orderList.add(
          //     Order.fromMap(
          //       json.decode(res.body)[i],
          //     ),
          //   );
          // }
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void logOut(BuildContext context) async {
    try {
      await box.remove('token');
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
            (route) => false,
      );
    } catch (e) {
      print(e.toString());
    }
  }

}

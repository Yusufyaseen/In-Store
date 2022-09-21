import 'dart:convert';

import 'package:amazon_cloning/features/admin/screens/screen.dart';
import 'package:amazon_cloning/widgets/bottom_bar.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../features/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../models/user.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService {
  static UserController userController = Get.put(UserController());
  static final box = GetStorage();
  static String? url = dotenv.get("SERVER_URL");

  static void signUpUser({
    required BuildContext context,
    required String name,
    required String password,
    required String email,
  }) async {
    try {
      UserModel userModel = UserModel(
        id: "",
        name: name,
        password: password,
        email: email,
        type: "",
        token: "",
        cart: [],
        address: '',
      );
      http.Response response = await http.post(Uri.parse('$url/signup'),
          body: userModel.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () async {
            showSnackBar(context, "Account is created.",
                color: GlobalVariables.success);
            await box.write("token", json.decode(response.body)['token']);
            userController.setUserModel(response.body);
            // ignore: use_build_context_synchronously
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static void signInUser({
    required BuildContext context,
    required String password,
    required String email,
  }) async {
    try {
      http.Response response = await http.post(Uri.parse('$url/signin'),
          body: json.encode({"email": email, "password": password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () async {
            await box.write("token", json.decode(response.body)['token']);
            userController.setUserModel(response.body);

            if (userController.user.type == "admin") {
              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(
                  context, AdminScreen.routeName, (route) => false);
            } else {
              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(
                  context, BottomBar.routeName, (route) => false);
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString(), color: Colors.yellow);
    }
  }

  static Future<bool> getUserData() async {
    try {
      String? token = box.read('token');
      if (token == null) {
        await box.write("token", '');
        return false;
      }
      http.Response tokenRes =
          await http.post(Uri.parse('$url/validate'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': token,
      });
      if (tokenRes.statusCode == 200) {
        userController.setUserModel(tokenRes.body);
        return true;
      }
      return false;
    } catch (e) {
      // showSnackBar(context, e.toString());
      return false;
    }
  }
}

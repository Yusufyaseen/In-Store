import 'dart:convert';

import 'package:amazon_cloning/constants/global_variables.dart';

import '../features/controllers/user_controller.dart';
import './utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

void httpErrorHandling(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) {
  UserController userController = Get.put(UserController());
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:{
      showSnackBar(context, json.decode(response.body)['message'],
          color: GlobalVariables.error400);
      userController.setLoadingToFalse();
    }
      break;
    case 500:{
      showSnackBar(context, json.decode(response.body)['message'], color: Colors.deepOrange);
      userController.setLoadingToFalse();
      Navigator.pop(context);
    }

      break;
    default:
      showSnackBar(context, json.decode(response.body)['message'], color: Colors.deepPurpleAccent);
  }
}

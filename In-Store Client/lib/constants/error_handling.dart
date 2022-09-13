import 'dart:convert';

import 'package:amazon_cloning/constants/global_variables.dart';

import './utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandling(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, json.decode(response.body)['message'],
          color: GlobalVariables.error400);
      break;
    case 500:
      showSnackBar(context, json.decode(response.body)['message'], color: Colors.deepOrange);
      break;
    default:
      showSnackBar(context, json.decode(response.body)['message'], color: Colors.deepPurpleAccent);
  }
}

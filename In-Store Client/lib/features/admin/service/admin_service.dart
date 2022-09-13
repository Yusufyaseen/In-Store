import 'dart:convert';
import 'dart:io';

import 'package:amazon_cloning/constants/utils.dart';
import 'package:amazon_cloning/features/controllers/products_controller.dart';
import 'package:amazon_cloning/features/controllers/user_controller.dart';
import 'package:amazon_cloning/models/category.dart';
import 'package:amazon_cloning/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';

class AdminService {
  ProductsController productsController = Get.put(ProductsController());
  String? url = dotenv.get("SERVER_URL");
  String? cloudName = dotenv.get("CLOUDINARY_NAME");
  String? uploadPreset = dotenv.get("UPLOAD_PRESET");
  UserController userController = Get.put(UserController());

  void sendFile({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      List<String> imageUrls = [];
      final cloudinary = CloudinaryPublic(cloudName!, uploadPreset!);
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: category));
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );
      http.Response response = await http.post(
          Uri.parse('$url/products/add-product'),
          body: product.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': userController.user.token,
          });
      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () async {
            showSnackBar(context, "Product is created.",
                color: GlobalVariables.success);
            productsController.setProduct(Product.fromMap(json.decode(response.body)['data']));
            userController.setLoading();
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> deleteProduct({
    required BuildContext context,
    required String id,
  }) async {
    try {
      http.Response response = await http.delete(
          Uri.parse('$url/products/delete-product'),
          body: json.encode({'id': id}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': userController.user.token,
          });

      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () async {
            showSnackBar(context, "Product is deleted.",
                color: GlobalVariables.success);

            productsController.setRestProduct(productsController
                .productsOfCategory
                .where((cat) => cat.id != id)
                .toList());
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void addCategory({
    required BuildContext context,
    required String name,
    required File image,
  }) async {
    try {
      String imageUrl;
      final cloudinary = CloudinaryPublic(cloudName!, uploadPreset!);

      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path, folder: 'Categories', tags: [name]),
      );
      imageUrl = res.secureUrl;
      Category_ category = Category_(name: name, image: imageUrl);
      http.Response response = await http.post(
          Uri.parse('$url/category/add-category'),
          body: category.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': userController.user.token,
          });
      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () async {
            showSnackBar(context, "Category is created.",
                color: GlobalVariables.success);
            productsController.setProductCategory(Category_.fromMap(json.decode(response.body)['data']));
            userController.setLoading();
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> deleteCategory({
    required BuildContext context,
    required String id,
    required String image,
  }) async {
    try {
      http.Response response = await http.delete(
          Uri.parse('$url/category/delete-category'),
          body: json.encode({'id': id}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': userController.user.token,
          });

      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () async {
            showSnackBar(context, "Category is deleted.",
                color: GlobalVariables.success);

            productsController.setRestProductCategories(productsController
                .productCategories
                .where((cat) => cat.id != id)
                .toList());
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getProducts({
    required BuildContext context,
    required String category,
  }) async {
    try {
      http.Response response = await http.get(
          Uri.parse('$url/products/$category'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': userController.user.token,
          });

      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () async {
            productsController.setProducts(json.decode(response.body)['data']) ;
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getCategories({
    required BuildContext context,
  }) async {
    try {
      http.Response response = await http.get(
          Uri.parse('$url/category/fetch-categories'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth-token': userController.user.token,
          });

      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () async {
            productsController
                .setProductCategories(json.decode(response.body)['data']);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

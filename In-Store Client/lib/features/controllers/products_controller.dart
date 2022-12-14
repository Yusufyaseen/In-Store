import 'package:amazon_cloning/models/category.dart';
import 'package:amazon_cloning/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController{
  List<Category_> productCategories = [];
  List<Product> productsOfCategory = [];
  List<Product> productsBySearch = [];
  Product dealOfDay = Product(name: "", description: "", quantity: 0, images: [], category: "", price: 0, rating: []);
  void setDealOfDay(Product product){
    dealOfDay = product;
    update();
  }
  void setProductCategories(List categories){
    productCategories = categories.map((category) => Category_.fromMap(category)).toList();
    update();
  }

  void setProductsBySearch(List products){
    productsBySearch = products.map((product) => Product.fromMap(product)).toList();
    update();
  }
  void setRestProductCategories(List<Category_> categories){
    productCategories = categories;
    update();
  }
  void setProductCategory(Category_ category){
    productCategories.add(category);
    update();
  }

  void setProducts(List products){
    productsOfCategory = products.map((product) => Product.fromMap(product)).toList();
    update();
  }
  void setRestProduct(List<Product> products){
    productsOfCategory = products;
    update();
  }
  void setProduct(Product product){
    productsOfCategory.add(product);
    update();
  }


}
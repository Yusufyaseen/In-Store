import 'package:amazon_cloning/models/category.dart';
import 'package:amazon_cloning/models/product.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController{
  List<Category_> productCategories = [];
  List<Product> productsOfCategory = [];
  void setProductCategories(List categories){
    productCategories = categories.map((category) => Category_.fromMap(category)).toList();
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
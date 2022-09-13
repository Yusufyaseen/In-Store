import 'package:amazon_cloning/features/admin/screens/add_product.dart';
import 'package:amazon_cloning/features/admin/service/admin_service.dart';
import 'package:amazon_cloning/features/controllers/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/global_variables.dart';
import '../../account/widgets/single_product.dart';
import '../../controllers/user_controller.dart';

class PostsScreen extends StatefulWidget {
  static const String routeName = "/posts";
  final String category;

  const PostsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  ProductsController productsController = Get.put(ProductsController());
  UserController userController = Get.put(UserController());
  AdminService adminService = AdminService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productsController.productsOfCategory = [];
  }

  void getProducts() async {
    await adminService.getProducts(context: context, category: widget.category);
  }

  void deleteProduct(String id) async {
    await adminService.deleteProduct(context: context, id: id);
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProduct.routeName,
        arguments: {'category': widget.category});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(
      init: ProductsController(),
      builder: (ProductsController productsController) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
                centerTitle: true,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient,
                  ),
                ),
                title: Text(widget.category)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: productsController.productsOfCategory.isEmpty
                ? const Center(
                    child: Text("There is no products."),
                  )
                : GridView.builder(
                    itemCount: productsController.productsOfCategory.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      final productData =
                          productsController.productsOfCategory[index];
                      return Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                      border: Border(bottom: BorderSide(
                                        color: Colors.black12,
                                        width: 1,
                                      ),)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(
                                      productData.images[0],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    productData.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                if (userController.user.type == 'admin')
                                  IconButton(
                                    onPressed: () =>
                                        deleteProduct(productData.id!),
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          floatingActionButton: userController.user.type == 'admin'
              ? FloatingActionButton(
                  onPressed: navigateToAddProduct,
                  tooltip: 'Add a Product',
                  child: const Icon(Icons.add),
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}

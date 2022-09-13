import 'package:amazon_cloning/features/admin/screens/add_category.dart';
import 'package:amazon_cloning/features/admin/screens/posts.dart';
import 'package:amazon_cloning/features/admin/service/admin_service.dart';
import 'package:amazon_cloning/features/controllers/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../account/widgets/single_product.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // ProductsController productsController = Get.put(ProductsController());
  AdminService adminService = AdminService();

  void navigateToAddCategory() {
    Navigator.pushNamed(context, AddCategory.routeName);
  }

  void deleteCategory(String id, String image) async {
    await adminService.deleteCategory(context: context, id: id, image: image);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProductsController(),
        builder: (ProductsController productsController) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: productsController.productCategories.isEmpty
                  ? const Center(
                      child: Text("There is no categories."),
                    )
                  : GridView.builder(
                      itemCount: productsController.productCategories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final categoryData =
                            productsController.productCategories[index];
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, PostsScreen.routeName,
                              arguments: {'category': categoryData.name}),
                          child: Card(
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: DecoratedBox(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                          color: Colors.black12,
                                          width: 1,
                                        ),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.network(
                                          categoryData.image,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        categoryData.name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => deleteCategory(
                                          categoryData.id!, categoryData.image),
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            floatingActionButton: FloatingActionButton(

              onPressed: navigateToAddCategory,
              tooltip: 'Add a category',
              child: const Icon(Icons.add),
            ),
            // floatingActionButtonLocation:
            // FloatingActionButtonLocation.centerFloat,
          );
        });
  }
}

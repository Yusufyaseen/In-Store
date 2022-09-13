import 'package:amazon_cloning/constants/global_variables.dart';
import 'package:amazon_cloning/features/admin/screens/posts.dart';
import 'package:amazon_cloning/features/controllers/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../account/widgets/single_product.dart';

class TopCategories extends StatefulWidget {
  const TopCategories({Key? key}) : super(key: key);

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(init: ProductsController(),builder: (ProductsController productsController){
      return SizedBox(
        height: 130,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productsController.productCategories.length,
            itemExtent: 155,
            itemBuilder: (ctx, index) {
              final categoryData = productsController.productCategories[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, PostsScreen.routeName, arguments: {'category': categoryData.name}),
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                        Text(
                          categoryData.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w800, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }
}

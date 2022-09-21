import 'package:amazon_cloning/features/cart/services/cart_service.dart';
import 'package:amazon_cloning/features/controllers/user_controller.dart';
import 'package:amazon_cloning/features/product_details/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/product.dart';
class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsService productDetailsServices =
  ProductDetailsService();
   CartServices cartServices = CartServices();
  UserController userController = Get.put(UserController());

  void increaseQuantity(Product product) {
    productDetailsServices.addToCart(
      context: context,
      id: product.id!,
    );
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(
      context: context,
      id: product.id!,
    );

  }

  @override
  Widget build(BuildContext context) {
    final productCart = userController.user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    int i = widget.index;

      return GetBuilder(init: UserController(), builder: (UserController control){
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                children: [
                  Image.network(
                    product.images[0],
                    fit: BoxFit.contain,
                    height: 135,
                    width: 135,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 235,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          width: 235,
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            '\$${product.price}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          width: 235,
                          padding: const EdgeInsets.only(left: 10),
                          child: const Text('Eligible for FREE Shipping'),
                        ),
                        Container(
                          width: 235,
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: const Text(
                            'In Stock',
                            style: TextStyle(
                              color: Colors.teal,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 25, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black12,
                      ),
                      child:

                      Row(
                        children: [
                          InkWell(
                            onTap: () => decreaseQuantity(product),
                            child: Container(
                              width: 35,
                              height: 32,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.remove,
                                size: 18,
                              ),
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12, width: 1.5),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Container(
                              width: 35,
                              height: 32,
                              alignment: Alignment.center,
                              child: Text(
                                control.user.cart[i]['quantity'].toString(),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => increaseQuantity(product),
                            child: Container(
                              width: 35,
                              height: 32,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.add,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      )


                  ),
                ],
              ),
            )
          ],
        );
      }
      );

  }
}

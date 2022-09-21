import 'package:amazon_cloning/features/account/screens/account_screen.dart';
import 'package:amazon_cloning/features/account/services/account_service.dart';
import 'package:amazon_cloning/features/account/widgets/single_product.dart';
import 'package:amazon_cloning/features/controllers/order_controller.dart';
import 'package:amazon_cloning/features/order_ddetails/screens/order_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/global_variables.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  AccountService accountService = AccountService();
  List images = [
    "https://images.unsplash.com/photo-1660077018619-687b91bdd342?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1660400652245-660640564256?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    "https://images.unsplash.com/photo-1660238140691-5a6a3dc925e1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=876&q=80",
    "https://images.unsplash.com/photo-1659784305324-4c30efe004b6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1660306630560-0ca0e7f47508?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxM3x8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60"
  ];

  void fetchMyOrders() async {
    await accountService.fetchMyOrders(context: context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMyOrders();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: OrderController(),
        builder: (OrderController orderController) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  height: 170,
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 20,
                    right: 0,
                  ),
                  child: orderController.myOrders.isNotEmpty ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: orderController.myOrders.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, OrderDetailsScreen.routeName,
                                arguments: {
                                  "order": orderController.myOrders[index]
                                });
                          },
                          child: SingleProduct(
                            image: orderController
                                .myOrders[index].products[0].images[0],
                          ),
                        );
                      }) : const Center(child: Text("There are no orders for you"),)),
            ],
          );
        });
  }
}

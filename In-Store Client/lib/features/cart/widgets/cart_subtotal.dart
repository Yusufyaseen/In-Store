import 'package:amazon_cloning/features/controllers/user_controller.dart';
import 'package:amazon_cloning/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/utils.dart';
class CartSubtotal extends StatelessWidget {
  const CartSubtotal({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());



    return GetBuilder(init: UserController(),builder: (UserController userController){
      return Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Text(
              'Subtotal ',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              '\$${getSum(userController.user)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    });
  }
}
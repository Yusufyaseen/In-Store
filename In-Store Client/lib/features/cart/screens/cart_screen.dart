import 'package:amazon_cloning/constants/utils.dart';
import 'package:amazon_cloning/features/address/screen/address_screen.dart';
import 'package:amazon_cloning/features/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/global_variables.dart';
import '../../../widgets/custom_button.dart';
import '../../home/widgets/address_box.dart';
import '../../search/screens/search_screen.dart';
import '../widgets/cart_product.dart';
import '../widgets/cart_subtotal.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  UserController userController = Get.put(UserController());
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: {"query": query});
  }
  void navigateToAddress(double sum){
    Navigator.pushNamed(context, AddressScreen.routeName, arguments: {"sum": sum});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: 'Proceed to Buy (${userController.user.cart.length} items)',
                onTap: () => navigateToAddress(getSum(userController.user)),
                color: Colors.yellow[600], height: height / 1.2 ,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(height: 5),
            userController.user.cart.isEmpty ? const Center(
              child: Text("There are no orders"),
            ):ListView.builder(
              itemCount: userController.user.cart.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CartProduct(
                  index: index,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

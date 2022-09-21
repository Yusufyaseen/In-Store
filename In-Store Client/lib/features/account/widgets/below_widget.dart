import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/global_variables.dart';
import '../../../models/user.dart';
import '../../controllers/user_controller.dart';

class BelowWidget extends StatelessWidget {
  const BelowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    UserModel user = userController.user;
    return Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: GetBuilder(
        init: UserController(),
        builder: (UserController controller){
          return Row(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Hello, ',
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: controller.user.name,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      )
    );
  }
}

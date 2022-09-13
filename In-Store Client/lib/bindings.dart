import 'package:get/get.dart';

import 'features/controllers/user_controller.dart';

class UserBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(() => UserController());
  }
}
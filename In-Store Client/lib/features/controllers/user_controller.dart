import '../../../models/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
    UserModel user = UserModel(id: "", name: "", password: "", email: "", type: "", token: "", cart: [], address: '');
    bool loading = false;
    void setUserModel(String source){
      user = UserModel.fromJson(source);
      update();
    }
    void setUserModelByObject(UserModel userModel){
      user = userModel;
      update();
    }
    void setLoadingToTrue(){
      loading = true;
      update();
    }
    void setLoadingToFalse(){
      loading = false;
      update();
    }
}
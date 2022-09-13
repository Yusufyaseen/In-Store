import '../../../models/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController{
    UserModel user = UserModel(id: "", name: "", password: "", email: "", type: "", token: "");
    bool loading = false;
    void setUserModel(String source){
      user = UserModel.fromJson(source);
      update();
    }
    void setLoading(){
      loading = !loading;
      update();
    }
}
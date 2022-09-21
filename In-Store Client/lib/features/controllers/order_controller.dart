import '../../../models/user.dart';
import 'package:get/get.dart';

import '../../models/order.dart';

class OrderController extends GetxController{
  List<Order> myOrders = [];
  void setOrders(List<Order> orders){
    myOrders = orders;
    update();
  }
}
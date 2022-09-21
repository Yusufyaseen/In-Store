import 'package:amazon_cloning/features/controllers/products_controller.dart';
import 'package:amazon_cloning/features/home/service/home_service.dart';
import 'package:amazon_cloning/features/home/widgets/carousal_slider.dart';
import 'package:amazon_cloning/features/home/widgets/deal_of_images.dart';
import 'package:amazon_cloning/features/home/widgets/top_categories.dart';
import 'package:amazon_cloning/features/search/screens/search_screen.dart';

import '../../../constants/global_variables.dart';
import '../../controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/address_box.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home_screen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController userController = Get.put(UserController());
  final ProductsController productsController = Get.put(ProductsController());
  HomeService homeService = HomeService();
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: {"query": query});
  }
  void fetchDealOfDay() async{
  await homeService.fetchDealOfDay(context: context);
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDealOfDay();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 3,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 10),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1),
                            ),
                            hintText: "Search in.store..",
                            hintStyle: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              AddressBox(),
              SizedBox(
                height: 5,
              ),
              TopCategories(),
              SizedBox(
                height: 0,
              ),
              CarouselImage(),
              DealOfImages(),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ));
  }
}

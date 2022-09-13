import 'package:amazon_cloning/features/home/widgets/carousal_slider.dart';
import 'package:amazon_cloning/features/home/widgets/deal_of_images.dart';
import 'package:amazon_cloning/features/home/widgets/top_categories.dart';

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
                            hintText: "Search Amazon.in",
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
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(Icons.mic, color: Colors.black, size: 25),
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
                height: 10,
              ),
              TopCategories(),

              CarouselImage(),
              DealOfImages()
            ],
          ),
        ));
  }
}

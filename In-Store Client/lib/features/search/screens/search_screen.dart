import 'package:amazon_cloning/features/controllers/products_controller.dart';
import 'package:amazon_cloning/features/home/widgets/stars.dart';
import 'package:amazon_cloning/features/product_details/screens/produc_screen.dart';
import 'package:amazon_cloning/features/search/services/SearchService.dart';
import 'package:amazon_cloning/models/rating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../controllers/user_controller.dart';
import '../../home/widgets/address_box.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search";
  final String searchQuery;

  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchService searchService = SearchService();
  UserController userController = Get.put(UserController());

  void fetchAllProducts(String text) async {
    String query = text.isEmpty ? widget.searchQuery : text;
    await searchService.fetchProducts(context: context, query: query);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProducts("");
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: ProductsController(),
        builder: (ProductsController productsController) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(65),
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
                            onFieldSubmitted: fetchAllProducts,
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
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1),
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
                  ],
                ),
              ),
            ),
            body: Padding(
                padding: const EdgeInsets.only( bottom: 20),
                child: productsController.productsBySearch.isEmpty
                    ? const Center(
                        child: LoadingIndicator(
                            colors: [Colors.black],
                            strokeWidth: 2,
                            indicatorType: Indicator.ballRotate),
                      )
                    : Column(
                      children: [
                        const AddressBox(),
                        Expanded(
                          child: ListView.builder(
                              itemCount: productsController.productsBySearch.length,
                              itemBuilder: (builder, index) {
                                Product productData =
                                    productsController.productsBySearch[index];
                                return Column(
                                  children: [

                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          ProductDetailsScreen.routeName,
                                          arguments: {"product": productData},
                                        );
                                      },
                                      child: SizedBox(
                                        height: height * 0.25,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: double.infinity,
                                              width: width * 0.4,
                                              child: DecoratedBox(
                                                decoration: const BoxDecoration(),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Image.network(
                                                    productData.images[0],
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Container(
                                              margin: const EdgeInsets.only(top: 10),
                                              width: width * 0.55,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: width * 0.65,
                                                    child: Text(
                                                      productData.name,
                                                      overflow: TextOverflow.visible,
                                                      maxLines: 3,
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w600, color: Colors.black38),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.65,
                                                    child:  Stars(rating: averageOfRating(productData.rating))
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.65,
                                                    child: Text(
                                                      "\$ ${productData.price}",
                                                      overflow: TextOverflow.visible,
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.65,
                                                    child: const Text(
                                                      "In Stock",
                                                      overflow: TextOverflow.visible,
                                                      style:  TextStyle(
                                                        color: Colors.teal,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 0.5,
                                      height: 1,
                                      color: Colors.grey,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    )),
          );
        });
  }
}

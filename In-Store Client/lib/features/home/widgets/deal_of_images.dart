import 'package:amazon_cloning/constants/global_variables.dart';
import 'package:amazon_cloning/constants/utils.dart';
import 'package:amazon_cloning/features/controllers/products_controller.dart';
import 'package:amazon_cloning/features/home/service/home_service.dart';
import 'package:amazon_cloning/features/home/widgets/stars.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/product.dart';
import '../../product_details/screens/produc_screen.dart';

class DealOfImages extends StatefulWidget {
  const DealOfImages({Key? key}) : super(key: key);

  @override
  State<DealOfImages> createState() => _DealOfImagesState();
}

class _DealOfImagesState extends State<DealOfImages> {
  ProductsController productsController = Get.put(ProductsController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(init: ProductsController(), builder: (ProductsController productsController) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.only( top: 10),
                alignment: Alignment.topLeft,
                child: const Text("Most rated product" ,style: TextStyle(fontWeight: FontWeight.w500),),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, top: 10),
                alignment: Alignment.topLeft,
                child: Text(productsController.dealOfDay.name,style:  const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: GlobalVariables.secondaryColor),),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(
                context,
                ProductDetailsScreen.routeName,
                arguments: {"product": productsController.dealOfDay},
              );
            },
            child: CarouselSlider(
              items: productsController.dealOfDay.images.map(
                    (i) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                autoPlayInterval:
                const Duration(seconds: 3),
                autoPlayAnimationDuration:
                const Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeIn,
                enlargeCenterPage: true,
                autoPlay: true,
                viewportFraction: 1,
                height: 200,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
            children: [
              Container(
                padding: const EdgeInsets.only( top: 10),
                alignment: Alignment.topLeft,
                child: Text(
                  '\$ ${productsController.dealOfDay.price}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding:
                const EdgeInsets.only(left: 10, top: 10),
                child: Stars(rating: averageOfRating(productsController.dealOfDay.rating))
              )
            ],
          ),

        ],
      );
    },);
  }
}

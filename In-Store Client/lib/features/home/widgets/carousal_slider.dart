import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: GlobalVariables.carouselImages.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return Builder(
            builder: (BuildContext context) => Image.network(
              GlobalVariables.carouselImages[index],
              fit: BoxFit.cover,
            ),
          );
        },
        options: CarouselOptions(
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.easeIn,
          enlargeCenterPage: true,
          autoPlay: true,
          viewportFraction: 1,
        ),
      ),
    );
  }
}
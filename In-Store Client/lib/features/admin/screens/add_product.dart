import 'package:amazon_cloning/constants/utils.dart';
import 'package:amazon_cloning/features/admin/service/admin_service.dart';
import 'package:amazon_cloning/features/controllers/user_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'dart:io';
import '../../../constants/global_variables.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';

class AddProduct extends StatefulWidget {
  static const String routeName = '/add-product';
  final String category;

  const AddProduct({Key? key, required this.category}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final AdminService adminService = AdminService();

  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  void selectImages() async {
    var result = await pickImages();
    setState(() {
      images = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: UserController(),
        builder: (UserController userController) {
          return Scaffold(
            backgroundColor: userController.loading == true
                ? Colors.white12.withOpacity(0.5)
                : null,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient,
                  ),
                ),
                centerTitle: true,
                title: const Text(
                  'Add Product',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Form(
                    key: _addProductFormKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20),
                      child: Column(
                        children: [
                          images.isNotEmpty
                              ? Column(
                                  children: [
                                    CarouselSlider.builder(
                                      itemCount: images.length,
                                      itemBuilder: (BuildContext context,
                                          int index, int realIndex) {
                                        return Builder(
                                          builder: (BuildContext context) =>
                                              Image.file(
                                            images[index],
                                            fit: BoxFit.cover,
                                            height: 200,
                                            colorBlendMode:
                                                userController.loading == true
                                                    ? BlendMode.colorBurn
                                                    : null,
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                        autoPlayInterval:
                                            const Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            const Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.easeIn,
                                        enlargeCenterPage: true,
                                        autoPlay: true,
                                        viewportFraction: 1,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          images = [];
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                )
                              : GestureDetector(
                                  onTap: selectImages,
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(10),
                                    dashPattern: const [10, 4],
                                    strokeCap: StrokeCap.round,
                                    child: Container(
                                      width: double.infinity,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.folder_open,
                                            size: 40,
                                          ),
                                          const SizedBox(height: 15),
                                          Text(
                                            'Select Product Images',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            controller: productNameController,
                            hintText: 'Product Name',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: descriptionController,
                            hintText: 'Description',
                            maxLines: 7,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: priceController,
                            hintText: 'Price',
                            number: true,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: quantityController,
                            hintText: 'Quantity',
                            number: true,
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(height: 10),
                          CustomButton(
                            text: 'Add',
                            onTap: () {
                              if (_addProductFormKey.currentState!.validate() &&
                                  images.isNotEmpty) {
                                adminService.sendFile(
                                    context: context,
                                    name: productNameController.text,
                                    description: descriptionController.text,
                                    price: double.parse(priceController.text),
                                    quantity:
                                        double.parse(quantityController.text),
                                    category: widget.category,
                                    images: images);
                                userController.setLoadingToTrue();
                              }
                            },
                            height: height,
                          ),
                        ],
                      ),
                    ),
                  ),
                  userController.loading == true
                      ? Positioned(
                          top: height * 0.3,
                          left: width * 0.4,
                          child: const SizedBox(
                            height: 70,
                            width: 70,
                            child: LoadingIndicator(
                                colors: [Colors.black],
                                indicatorType: Indicator.squareSpin),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          );
        });
  }
}

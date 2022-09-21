import 'dart:io';

import 'package:amazon_cloning/features/controllers/user_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../service/admin_service.dart';

class AddCategory extends StatefulWidget {
  static const String routeName = '/add-category';
  const AddCategory({Key? key,}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController categoryNameController = TextEditingController();
  final AdminService adminService = AdminService();

  String category = 'Mobiles';
  File? image;
  final _addCategoryFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    categoryNameController.dispose();
  }

  void selectImages() async {
    var result = await pickImage();

    setState(() {
      if (result != null) {
        image = result;
      }
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
                'Add Category',
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
                  key: _addCategoryFormKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20),
                    child: Column(
                      children: [
                        image != null
                            ? Column(
                                children: [
                                  Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                    height: 150,
                                    colorBlendMode:
                                        userController.loading == true
                                            ? BlendMode.colorBurn
                                            : null,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        image = null;
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
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 150,
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
                                          'Select Category Image',
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
                          controller: categoryNameController,
                          hintText: 'Product Name',
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: 'Add Category',
                          onTap: () {
                            if (_addCategoryFormKey.currentState!.validate() &&
                                image != null) {
                              adminService.addCategory(
                                context: context,
                                name: categoryNameController.text,
                                image: image!,
                              );
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
                              colors: [Colors.white],
                              indicatorType: Indicator.squareSpin),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        );
      },
    );
  }
}

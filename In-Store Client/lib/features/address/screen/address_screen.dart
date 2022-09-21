import 'package:amazon_cloning/features/address/service/address_service.dart';
import 'package:amazon_cloning/features/controllers/user_controller.dart';
import 'package:amazon_cloning/features/home/screens/screen.dart';
import 'package:amazon_cloning/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';

import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../widgets/bottom_bar.dart';
import '../../../widgets/custom_textfield.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address";
  final double totalAmount;

  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  UserController userController = Get.put(UserController());
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  AddressService addressService = AddressService();
  List<PaymentItem> paymentItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount.toString(),
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    cityController.dispose();
    countryController.dispose();
  }

  void onApplePayResult(res) {
    // if (userController
    //     .user
    //     .address
    //     .isEmpty) {
    //   addressServices.saveUserAddress(
    //       context: context, address: addressToBeUsed);
    // }
    // addressServices.placeOrder(
    //   context: context,
    //   address: addressToBeUsed,
    //   totalSum: double.parse(widget.totalAmount),
    // );
  }

  void onGooglePayResult(String address) {
    if (userController.user.address.isEmpty) {
      addressService.saveUserAddress(context: context, address: address);
    }
    // addressServices.placeOrder(
    //   context: context,
    //   address: addressToBeUsed,
    //   totalSum: double.parse(widget.totalAmount),
    // );
  }

  void onSubmit(String address) {
    if (address.isEmpty) {
      return;
    }
    if (userController.user.address.isEmpty) {
      addressService.saveUserAddress(context: context, address: address);
    }
    addressService.placeOrder(
      context: context,
      address: address,
      totalSum: widget.totalAmount,
    );
    Navigator.pushNamedAndRemoveUntil(context, BottomBar.routeName, (route) => false);
    showSnackBar(context, 'Your order has been placed!', color: GlobalVariables.success);
  }

  String payPressed(String addressFromProvider) {
    String addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        countryController.text.isNotEmpty;
    debugPrint(isForm.toString());
    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${countryController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
    return addressToBeUsed;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final String address = userController.user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: areaController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: cityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: countryController,
                      hintText: 'Country',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              // ApplePayButton(
              //   width: double.infinity,
              //   style: ApplePayButtonStyle.whiteOutline,
              //   type: ApplePayButtonType.buy,
              //   paymentConfigurationAsset: 'applepay.json',
              //   onPaymentResult: onApplePayResult,
              //   paymentItems: paymentItems,
              //   margin: const EdgeInsets.only(top: 15),
              //   height: 50,
              //   // onPressed: () => payPressed(address),
              // ),
              // const SizedBox(height: 10),
              // GooglePayButton(
              //   // onPressed: () => payPressed(address),
              //   paymentConfigurationAsset: 'gpay.json',
              //   onPaymentResult: (res) => onGooglePayResult(address),
              //   paymentItems: paymentItems,
              //   height: 50,
              //   type: GooglePayButtonType.buy,
              //   margin: const EdgeInsets.only(top: 15),
              //   loadingIndicator: const Center(
              //     child: CircularProgressIndicator(),
              //   ),
              // ),
              const SizedBox(height: 10),
              CustomButton(
                  text: "Order Now",
                  onTap: () => onSubmit(payPressed(address)),
                  height: height),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

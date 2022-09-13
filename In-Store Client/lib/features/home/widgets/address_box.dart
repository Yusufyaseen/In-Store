import 'package:amazon_cloning/features/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressBox extends StatefulWidget {
  const AddressBox({Key? key}) : super(key: key);

  @override
  State<AddressBox> createState() => _AddressBoxState();
}

class _AddressBoxState extends State<AddressBox> {
  TextOverflow textOverflow = TextOverflow.ellipsis;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    UserController userController = Get.put(UserController());
    return Container(
      height: height * 0.12,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 162, 236, 233),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Delivered to ${userController.user.name} jlbwhjkvbwvowbvwvu cwcwcwccovuo",
                style: const TextStyle(fontWeight: FontWeight.w500),
                overflow: textOverflow,
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(
              right: 15,

            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  textOverflow = (textOverflow == TextOverflow.ellipsis) ? TextOverflow.fade: TextOverflow.ellipsis;
                });
              },
              child: Icon(
                (textOverflow == TextOverflow.ellipsis) ? Icons.arrow_drop_down_outlined : Icons.arrow_drop_up_outlined,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

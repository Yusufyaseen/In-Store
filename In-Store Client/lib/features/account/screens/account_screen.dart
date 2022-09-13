import 'package:amazon_cloning/constants/global_variables.dart';
import 'package:amazon_cloning/features/account/widgets/below_widget.dart';
import 'package:amazon_cloning/features/account/widgets/orders.dart';
import 'package:amazon_cloning/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';


class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/amazon.png",
                height: 110,
                width: 120,
                color: Colors.black,
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    const Icon(Icons.notifications_outlined),
                    SizedBox(width: width*0.01,),
                    const Icon(Icons.search)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: const [
          BelowWidget(),
          SizedBox(height: 10,),
          TopButtons(),
          SizedBox(height: 20,),
          Orders(),
        ],
      ),
    );
  }
}

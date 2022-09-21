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
            children: const [
              Expanded(
                child: Text("In.Store", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25,color: GlobalVariables.unselectedNavBarColor),)
              ),

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

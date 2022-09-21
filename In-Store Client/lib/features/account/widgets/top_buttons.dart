import 'package:amazon_cloning/features/account/services/account_service.dart';
import 'package:amazon_cloning/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  final AccountService accountService = AccountService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Row(
          children: [
            AccountButton(text: "Your Orders", onTap: (){}),
            AccountButton(text: "Log Out", onTap: () => accountService.logOut(context))
          ],
        ),
      ],
    );
  }
}

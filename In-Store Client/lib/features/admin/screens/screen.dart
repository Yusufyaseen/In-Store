import 'package:amazon_cloning/features/account/services/account_service.dart';
import 'package:amazon_cloning/features/admin/screens/order_screen.dart';
import 'package:amazon_cloning/features/admin/screens/posts.dart';
import 'package:amazon_cloning/features/admin/service/admin_service.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import 'analytics.dart';
import 'categories.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);
  static const String routeName = "/admin-screen";

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  AdminService adminService = AdminService();
  AccountService accountService = AccountService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const CategoriesScreen(),
    // const AnalyticsScreen(),
    const OrderScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: Container(
                    padding: const EdgeInsets.only(top: 8),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "In.Store",
                      style: TextStyle(
                          color: GlobalVariables.unselectedNavBarColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 25),
                    )),
              ),
              IconButton(
                  onPressed: () => accountService.logOut(context),
                  icon: const Icon(Icons.logout_outlined))
            ],
          ),
        ),
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // POSTS
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),
          // ANALYTICS
          // BottomNavigationBarItem(
          //   icon: Container(
          //     width: bottomBarWidth,
          //     decoration: BoxDecoration(
          //       border: Border(
          //         top: BorderSide(
          //           color: _page == 1
          //               ? GlobalVariables.selectedNavBarColor
          //               : GlobalVariables.backgroundColor,
          //           width: bottomBarBorderWidth,
          //         ),
          //       ),
          //     ),
          //     child: const Icon(
          //       Icons.analytics_outlined,
          //     ),
          //   ),
          //   label: '',
          // ),
          // ORDERS
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.all_inbox_outlined,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

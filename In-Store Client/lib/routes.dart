import 'package:amazon_cloning/features/admin/screens/add_category.dart';
import 'package:amazon_cloning/features/admin/screens/add_product.dart';
import 'package:amazon_cloning/features/admin/screens/posts.dart';
import 'package:amazon_cloning/features/admin/screens/screen.dart';
import 'package:amazon_cloning/widgets/bottom_bar.dart';

import 'features/home/screens/screen.dart';

import './features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );
    case AddProduct.routeName:{
      final Map arguments = routeSettings.arguments as Map;
      String cat = arguments['category'];
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddProduct(category: cat,),
      );}
    case AddCategory.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddCategory(),
      );
    case PostsScreen.routeName:
      {
        final Map arguments = routeSettings.arguments as Map;
        String cat = arguments['category'];
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) =>  PostsScreen(
            category: cat
          ),
        );
      }

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}

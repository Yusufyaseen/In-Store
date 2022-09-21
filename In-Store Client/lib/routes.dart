import 'package:amazon_cloning/features/address/screen/address_screen.dart';
import 'package:amazon_cloning/features/admin/screens/add_category.dart';
import 'package:amazon_cloning/features/admin/screens/add_product.dart';
import 'package:amazon_cloning/features/admin/screens/posts.dart';
import 'package:amazon_cloning/features/admin/screens/screen.dart';
import 'package:amazon_cloning/features/product_details/screens/produc_screen.dart';
import 'package:amazon_cloning/features/search/screens/search_screen.dart';
import 'package:amazon_cloning/models/product.dart';
import 'package:amazon_cloning/widgets/bottom_bar.dart';

import 'features/home/screens/screen.dart';

import './features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';

import 'features/order_ddetails/screens/order_details.dart';
import 'models/order.dart';

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
    case AddProduct.routeName:
      {
        final Map arguments = routeSettings.arguments as Map;
        String cat = arguments['category'];
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AddProduct(
            category: cat,
          ),
        );
      }
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
          builder: (_) => PostsScreen(category: cat),
        );
      }

    case SearchScreen.routeName:
      {
        final Map arguments = routeSettings.arguments as Map;
        String query = arguments['query'];
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(searchQuery: query),
        );
      }

    case AddressScreen.routeName:
      {
        final Map arguments = routeSettings.arguments as Map;
        double sum = arguments['sum'];
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AddressScreen(totalAmount: sum,),
        );
      }

    case ProductDetailsScreen.routeName:
      {
        final Map arguments = routeSettings.arguments as Map;
        Product product = arguments['product'];
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailsScreen(product: product),
        );
      }

    case OrderDetailsScreen.routeName:
      {
        final Map arguments = routeSettings.arguments as Map;
        Order order = arguments['order'];
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetailsScreen(order: order),
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

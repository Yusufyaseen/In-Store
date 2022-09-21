import 'package:amazon_cloning/features/admin/screens/screen.dart';
import 'package:amazon_cloning/features/admin/service/admin_service.dart';
import 'package:amazon_cloning/features/home/service/home_service.dart';
import 'package:amazon_cloning/widgets/bottom_bar.dart';

import './features/auth/services/auth_service.dart';
import 'package:get_storage/get_storage.dart';

import './features/auth/screens/auth_screen.dart';
import './routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './features/controllers/user_controller.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  UserController userController = Get.put(UserController());
  AdminService adminService = AdminService();
  HomeService homeService = HomeService();
  final box = GetStorage();
  bool a = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllCategories();
    AuthService.getUserData().then((value) {
      setState(() {
        a = value;
      });
    });

  }

  void fetchAllCategories() async {
    await adminService.getCategories(context: context);

  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialBinding: UserBinding(),
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: userController.user.token.isNotEmpty
          ? userController.user.type == "user"
              ? const BottomBar()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}

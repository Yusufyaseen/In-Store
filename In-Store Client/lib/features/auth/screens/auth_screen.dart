import '../../../features/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../features/auth/services/auth_service.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth_screen";

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final UserController userController = Get.put(UserController());
  final box = GetStorage();
  Auth _auth = Auth.signUp;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: height * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ListTile(
                  tileColor: _auth == Auth.signUp
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  title: const Text(
                    "Create account",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    value: Auth.signUp,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                    activeColor: GlobalVariables.secondaryColor,
                  ),
                ),
                if (_auth == Auth.signUp)
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.02, horizontal: width * 0.02),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: _usernameController, hintText: "Name"),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomTextField(
                              controller: _emailController, hintText: "Email"),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomTextField(
                              controller: _passwordController,
                              hintText: "Password"),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomButton(
                              text: "Sign-Up",
                              height: height,
                              onTap: () {
                                if (_signUpFormKey.currentState!.validate()) {
                                  AuthService.signUpUser(
                                      name: _usernameController.text,
                                      password: _passwordController.text,
                                      email: _emailController.text,
                                      context: context);
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signIn
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  title: const Text(
                    "Sign-In",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    value: Auth.signIn,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                    activeColor: GlobalVariables.secondaryColor,
                  ),
                ),
                if (_auth == Auth.signIn)
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.02, horizontal: width * 0.02),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: _emailController, hintText: "Email"),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomTextField(
                              controller: _passwordController,
                              hintText: "Password"),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomButton(
                              text: "Sign-In", height: height, onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                              AuthService.signInUser(
                                  password: _passwordController.text,
                                  email: _emailController.text,
                                  context: context);

                            }
                          })
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

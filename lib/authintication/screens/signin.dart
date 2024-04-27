import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:places/authintication/controllers/auth_controller.dart';

import '../../home/home.dart';
import '../styles/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_formfield.dart';
import '../widgets/custom_header.dart';
import '../widgets/custom_richtext.dart';
import 'signup.dart';

class Signin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController auth = Get.put(AuthController());
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.blue,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: AppColors.blue,
          ),
          CustomHeader(
            text: 'Log In.',
            onTap: () {},
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: AppColors.whiteshade,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.09),
                      child: Image.asset("assets/images/login.png"),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomFormField(
                      headingText: "Email",
                      hintText: "Email",
                      obsecureText: false,
                      suffixIcon: const SizedBox(),
                      controller: auth.emailController,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                      headingText: "Password",
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text,
                      hintText: "At least 8 Character",
                      obsecureText: true,
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.visibility), onPressed: () {}),
                      controller: auth.passwordController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: AppColors.blue.withOpacity(0.7),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    auth.isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : AuthButton(
                            onTap: () {
                              auth.login(
                                auth.email,
                                auth.password,
                              );
                            },
                            text: 'Sign In',
                          ),
                    CustomRichText(
                      discription: "Don't already Have an account?",
                      text: "Sign Up",
                      onTap: () {
                        Get.to(SignUp());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

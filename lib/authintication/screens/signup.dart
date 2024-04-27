import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/home.dart';
import '../controllers/auth_controller.dart';
import '../styles/app_colors.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_formfield.dart';
import '../widgets/custom_header.dart';
import '../widgets/custom_richtext.dart';

import 'signin.dart';

class SignUp extends StatelessWidget {
  AuthController auth = Get.find();
  @override
  Widget build(BuildContext context) {
    setStatusBarColor(AppColors.blue);

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: AppColors.blue,
          ),
          CustomHeader(text: 'Sign Up.', onTap: () {}),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.08,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: AppColors.whiteshade,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32))),
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
                      height: 16,
                    ),
                    CustomFormField(
                      headingText: "UserName",
                      hintText: "username",
                      obsecureText: false,
                      suffixIcon: const SizedBox(),
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text,
                      controller: auth.userNameController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                      headingText: "Email",
                      hintText: "Email",
                      obsecureText: false,
                      suffixIcon: const SizedBox(),
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.emailAddress,
                      controller: auth.emailController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormField(
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text,
                      controller: auth.passwordController,
                      headingText: "Password",
                      hintText: "At least 8 Character",
                      obsecureText: true,
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.visibility), onPressed: () {}),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    auth.isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : AuthButton(
                            onTap: () => auth.signUp(
                                email: auth.email, password: auth.password),
                            text: 'Sign Up',
                          ),
                    CustomRichText(
                      discription: 'Already Have an account? ',
                      text: 'Log In here',
                      onTap: () => Get.to(Signin()),
                    )
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:places/authintication/utils/constants.dart';
import 'package:places/home/home.dart';

import '../styles/app_colors.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String get email => emailController.text.trim();
  String get password => passwordController.text.trim();
  RxBool isLoading = false.obs;

  final userNameController = TextEditingController();

  String get userName => userNameController.text.trim();


  void signUp({required String? email, required String? password}) async {
    try {
      isLoading.value = true;
      await firebaseAuth
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then(
        (value) {
          isLoading.value = false;
          Get.offAll(const HomePage());
        },
      );
    } on FirebaseAuthException catch (error) {
      isLoading.value = false;
      String? title = error.code;
      String? message;
      if (error.code == 'week-password') {
        message = 'كلمة المرور ضعيفة ';
      } else if (error.code == 'email-already-in-use') {
        message = 'هذا الايميل مستخدم بالفعل ';
      } else {
        message = error.message.toString();
      }
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.GROUNDED,
        backgroundColor: AppColors.lightblue,
        colorText: AppColors.hintText,
      );
    } catch (error) {
      isLoading.value = false;

      Get.snackbar('حدث خطأ', error.toString());
    }
  }

  void login(String email, String password) async {
    isLoading.value = true;
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        isLoading.value = false;
        Get.to(HomePage());
      });
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('حدث خطأ', error.toString());
    }
  }

}

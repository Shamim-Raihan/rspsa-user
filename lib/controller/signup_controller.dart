import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/screens/common/account_select_screen.dart';

class SignupController extends GetxController {
  var nameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;

  var passwordObscure = false.obs;
  var confirmPasswordObscure = false.obs;

  var isSignup = false.obs;

  singup() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.value.text,
              password: passwordController.value.text)
          .then((value) {
        isSignup.value = true;
        Get.to(() => AccountSelectScreen());
      });
    } catch (e) {
      log(e.toString());
      EasyLoading.showToast('Something went wrong');
    }
  }
}

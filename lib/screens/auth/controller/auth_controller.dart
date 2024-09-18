import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/screens/auth/repository/auth_repository.dart';
import 'package:rspsa_user/screens/auth/views/login_screen.dart';

class AuthController extends GetxController {
  var nameController = TextEditingController().obs;
  var mobileController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var passwordObscure = false.obs;
  var confirmPasswordObscure = false.obs;
  var isSignup = false.obs;
  Rx<String?> selectedRole = Rx<String?>(null);
  List<String> role = ['Student', 'Teacher', 'Employee', 'School'];

  void updateSelectedCountry(String? value) {
    selectedRole.value = value;
  }

  signup() async {
    try {
      Map<String, dynamic> payload = {
        "type": selectedRole.value,
        "name": nameController.value.text,
        "email": emailController.value.text,
        "mobile": mobileController.value.text,
        "password": passwordController.value.text,
        "password_confirmation": confirmPasswordController.value.text
      };
      var response = await AuthRepository().signup(payload: payload);
      if (response != null) {
        if (response.status == 200) {
          EasyLoading.showToast(response.msg!);
          Get.offAll(() => const LoginScreen());
        }
      } else {
        EasyLoading.showToast(response!.msg!);
      }
    } catch (e) {
      EasyLoading.showToast('Login failed');
      log('Error while signing up form controller: $e');
    }
  }
}

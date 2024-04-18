import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/screens/student_portal/repository/student_signup_repository.dart';

class StudentSignupController extends GetxController {
  var emailController = TextEditingController().obs;
  var mobileController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;

  var addressController = TextEditingController().obs;
  var aadharController = TextEditingController().obs;

  var schoolNameController = TextEditingController().obs;
  var schoolAddressController = TextEditingController().obs;
  var appearingClassController = TextEditingController().obs;
  var accountNumberController = TextEditingController().obs;
  var ifscCodeController = TextEditingController().obs;
  var utrNumberController = TextEditingController().obs;
  var declarationController = TextEditingController().obs;
  var agree = false.obs;

  var registrationForController = TextEditingController().obs;
  var nameController = TextEditingController().obs;
  var sdcoController = TextEditingController().obs;
  var visiblepass = false.obs;
  var selectedOption = 0.obs;
  var selectedValue = "Select".obs;

  var isLoginCompeleted = false.obs;

  var programCategoryList = [].obs;

  Future<void> getProgramCategoryList() async {
    try {
      EasyLoading.show();
      var response = await StudentSignupRepository().getProgramCategoryList();
      EasyLoading.dismiss();
      programCategoryList.value = response.data!;
      log('programCategoryList len : ${programCategoryList.length}');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error form getProgramCategoryList: $e');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:rspsa_user/controller/signup_controller.dart';

import '../repository/school_repository.dart';

class SchoolLoginController extends GetxController {
  var schoolRegistrationNumberController = TextEditingController().obs;
  var schoolEmailIdController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var conpasswordController = TextEditingController().obs;

  var schooladdressController = TextEditingController().obs;
  var schooldireactorNameController = TextEditingController().obs;
  var direactorContactNumberController = TextEditingController().obs;
  var totalStudentController = TextEditingController().obs;
  var totalTeacherController = TextEditingController().obs;

  var schoolNameController = TextEditingController().obs;
  var schoolMobileController = TextEditingController().obs;
  var visiblepass = false.obs;
  var convisiblepass = false.obs;
  var submitting=false.obs;
  Future<void> createSchool() async{
    submitting.value=true;
    SignupController signupController = Get.find();
    await SchoolRepository().submitSchoolDetails(
        schoolName: schoolNameController.value.text,
        schoolRegistrationNumber: schoolRegistrationNumberController.value.text,
        email: schoolEmailIdController.value.text,
        mobile: schoolMobileController.value.text,
        password: signupController.passwordController.value.text,
        schoolAddress: schooladdressController.value.text,
        schoolDirectorName: schooldireactorNameController.value.text,
        directorContactNumber: direactorContactNumberController.value.text,
        totalStudent: totalStudentController.value.text,
        totalTeacher: totalTeacherController.value.text);

    submitting.value=false;
  }
  bool isEmailValid(String email) {
    // Regular expression pattern for validating email addresses
    // This pattern checks for basic email format but doesn't guarantee the email exists or is valid
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );

    // Check if the email matches the regular expression pattern
    return emailRegex.hasMatch(email);
  }
  bool isSchoolDetailsValid({
    required String schoolName,
    required String schoolRegistrationNumber,
    required String email,
    required String mobile,
    required String password,
    required String schoolAddress,
    required String schoolDirectorName,
    required String directorContactNumber,
    required String totalStudent,
    required String totalTeacher,
  }) {
    return !(
        schoolName.isEmpty ||
            schoolRegistrationNumber.isEmpty ||
            email.isEmpty ||
            mobile.isEmpty ||
            password.isEmpty ||
            schoolAddress.isEmpty ||
            schoolDirectorName.isEmpty ||
            directorContactNumber.isEmpty ||
            totalStudent.isEmpty ||
            totalTeacher.isEmpty ||
            schoolName == "" ||
            schoolRegistrationNumber == "" ||
            email == "" ||
            mobile == "" ||
            password == "" ||
            schoolAddress == "" ||
            schoolDirectorName == "" ||
            directorContactNumber == "" ||
            totalStudent == "" ||
            totalTeacher == ""
    );
  }
  bool isPasswordValid(String password) {
    // Check if the password has at least 10 characters
    if (password.length < 10) {
      return false;
    }

    // Check if the password contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false;
    }

    // Check if the password contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return false;
    }

    // Check if the password contains at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      return false;
    }

    // Check if the password contains at least one special character
    if (!password.contains(RegExp(r'[!@£\$%^&]'))) {
      return false;
    }

    // If all conditions are met, return true
    return true;
  }

}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/controller/signup_controller.dart';
import 'package:rspsa_user/models/login_response.dart';
import 'package:rspsa_user/repository/login_repository.dart';
import 'package:rspsa_user/screens/common/account_select_screen.dart';
import 'package:rspsa_user/screens/common/login_screen.dart';
import 'package:rspsa_user/screens/student_portal/controller/student_signup_controller.dart';
import 'package:rspsa_user/utils/constants.dart';
import 'package:rspsa_user/utils/shared_preference_helper.dart';

import '../screens/employee_portal/employee_home_screen.dart';
import '../screens/employee_portal/employee_signup_screen.dart';
import '../screens/school_portal/school_home_screen.dart';
import '../screens/school_portal/school_signup_screen.dart';
import '../screens/student_portal/home_screen.dart';
import '../screens/student_portal/student_signup_screen.dart';
import '../screens/teacher_portal/teacher_home_screen.dart';
import '../screens/teacher_portal/teacher_signup_screen.dart';

class LoginController extends GetxController {
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

  @override
  void onInit() {
    // checkUserLoginStatus();
    super.onInit();
  }

  checkUserLoginStatus() async {
    bool? isUserLogedIn =
        await SharedPreferenceHelper().getBool(key: isLogedIn);
    if (isUserLogedIn!) {
      String? userRole = await SharedPreferenceHelper().getString(key: role);
      if (userRole! == "student") {
        Get.offAll(() => const HomeScreen());
      }
      if (userRole == "school") {
        Get.offAll(() => const SchoolHomeScreen());
      }
      if (userRole == "teacher") {
        Get.offAll(() => const TeacherHomeScreen());
      }
      if (userRole == "employee") {
        Get.offAll(() => const EmployeeHomeScreen());
      }
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  firebaseLogin() {
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.value.text,
              password: passwordController.value.text)
          .then((value) {
        Get.to(() => AccountSelectScreen());
      });
    } catch (e) {
      EasyLoading.showToast('Something went wrong');
    }
  }

  defineType() async {
    SignupController signupController = Get.put(SignupController());
    StudentSignupController studentSignupController =
        Get.put(StudentSignupController());
    if (signupController.isSignup.value) {
      if (selectedOption.value == 1) {
        await studentSignupController.getTalentList();
        Get.off(() => const StudentSignupScreen());
      }
      if (selectedOption.value == 2) {
        Get.off(() => const TeacherSignupScreen());
      }
      if (selectedOption.value == 3) {
        Get.off(() => const SchoolSignUpScreen());
      }
      if (selectedOption.value == 4) {
        Get.off(() => const EmployeeSignUpScreen());
      }
    } else {
      login();
    }
  }

  void login() async {
    isLoginCompeleted.value = false;

    try {
      EasyLoading.show();
      final response = await LoginRepository().login(
        email: emailController.value.text,
        password: passwordController.value.text,
      );
      if (response.status!) {
        saveUserData(loginResponse: response);
        EasyLoading.dismiss();
        EasyLoading.showToast(response.msg!,
            duration: const Duration(seconds: 2));
        isLoginCompeleted.value = true;
        if (selectedOption.value == 1 &&
            response.data!.user!.role! == 'student') {
          Get.offAll(() => const HomeScreen());
        }
        if (selectedOption.value == 2 &&
            response.data!.user!.role! == 'teacher') {
          Get.offAll(() => const TeacherHomeScreen());
        }
        if (selectedOption.value == 3 &&
            response.data!.user!.role! == 'school') {
          Get.offAll(() => const SchoolHomeScreen());
        }
        if (selectedOption.value == 4 &&
            response.data!.user!.role! == 'employee') {
          Get.offAll(() => const EmployeeHomeScreen());
        }
      } else {
        EasyLoading.dismiss();
        EasyLoading.showToast(response.msg!,
            duration: const Duration(seconds: 2));
      }
    } catch (e) {
      EasyLoading.dismiss();
      log('Error occur when login: $e');
      EasyLoading.showToast('Something went wrong',
          duration: const Duration(seconds: 2));
    }
  }

  void logout() async {
    try {
      EasyLoading.show();
      String? userAccessToken =
          await SharedPreferenceHelper().getString(key: accessToken);
      await SharedPreferenceHelper().setBool(key: isLogedIn, value: false);
      var response =
          await LoginRepository().logout(accessToken: userAccessToken!);
      EasyLoading.showToast(response.message!);
      Get.offAll(() => AccountSelectScreen());
    } catch (e) {
      log('Error occur when user logout: $e');
      EasyLoading.showToast('Something went wrong');
    }
  }

  void saveUserData({required LoginResponse loginResponse}) async {
    await SharedPreferenceHelper().setBool(key: isLogedIn, value: true);
    await SharedPreferenceHelper().setString(
        key: userId, value: loginResponse.data!.user!.details!.userId ?? '');
    await SharedPreferenceHelper().setString(
        key: userName, value: loginResponse.data!.user!.details!.name ?? '');
    await SharedPreferenceHelper().setString(
        key: accessToken, value: loginResponse.data!.accessToken ?? '');
    await SharedPreferenceHelper()
        .setString(key: tokenType, value: loginResponse.data!.tokenType ?? '');
    await SharedPreferenceHelper().setString(
        key: uniqueCode, value: loginResponse.data!.user!.uniqueCode ?? '');
    await SharedPreferenceHelper().setString(
        key: email, value: loginResponse.data!.user!.details!.email ?? '');
    await SharedPreferenceHelper().setString(
        key: mobile, value: loginResponse.data!.user!.details!.mobile ?? '');
    await SharedPreferenceHelper().setString(
        key: address, value: loginResponse.data!.user!.details!.address ?? '');
    await SharedPreferenceHelper().setString(
        key: image, value: loginResponse.data!.user!.details!.photo ?? '');
    await SharedPreferenceHelper().setString(
        key: status, value: loginResponse.data!.user!.details!.status ?? '');
    await SharedPreferenceHelper()
        .setString(key: role, value: loginResponse.data!.user!.role ?? '');
    await SharedPreferenceHelper().setString(
        key: refCode, value: loginResponse.data!.user!.refCode ?? '');
    await SharedPreferenceHelper().setString(
        key: totalPayout, value: loginResponse.data!.user!.totalPayout ?? '');
    await SharedPreferenceHelper().setString(
        key: paidAmount, value: loginResponse.data!.user!.paidAmount ?? '');
    await SharedPreferenceHelper().setString(
        key: dueAmount, value: loginResponse.data!.user!.dueAmount ?? '');
    await SharedPreferenceHelper().setString(
        key: bankName,
        value: loginResponse.data!.user!.details!.bankName ?? '');
    await SharedPreferenceHelper().setString(
        key: accountHolderName,
        value: loginResponse.data!.user!.details!.accountHolderName ?? '');
    await SharedPreferenceHelper().setString(
        key: accountNumber,
        value: loginResponse.data!.user!.details!.accountNumber ?? '');
    await SharedPreferenceHelper().setString(
        key: ifseCode,
        value: loginResponse.data!.user!.details!.ifscCode ?? '');
    await SharedPreferenceHelper().setString(
        key: talentId,
        value: loginResponse.data!.user!.details!.talentId ?? '');
    await SharedPreferenceHelper().setString(
        key: programId,
        value: loginResponse.data!.user!.details!.programId ?? '');
    await SharedPreferenceHelper().setString(
        key: talentDetailsId,
        value: loginResponse.data!.user!.details!.talentDetailId ?? '');
    await SharedPreferenceHelper().setString(
        key: registrationFor,
        value: loginResponse.data!.user!.details!.registrationFor ?? '');
    await SharedPreferenceHelper().setString(
        key: enrolmentFee,
        value: loginResponse.data!.user!.details!.enrollmentFee ?? '');
    await SharedPreferenceHelper().setString(
        key: aadharNumber,
        value: loginResponse.data!.user!.details!.aadharNumber ?? '');
    await SharedPreferenceHelper().setString(
        key: schoolOrInstututionName,
        value: loginResponse.data!.user!.details!.schoolOrInstituteName ?? '');
    await SharedPreferenceHelper().setString(
        key: schoolOrInstututionAddress,
        value:
            loginResponse.data!.user!.details!.schoolOrInstituteAddress ?? '');
    await SharedPreferenceHelper().setString(
        key: currentEducationProof,
        value: loginResponse.data!.user!.details!.currentEducationProof ?? '');
    await SharedPreferenceHelper().setString(
        key: signature,
        value: loginResponse.data!.user!.details!.signature ?? '');
    await SharedPreferenceHelper().setString(
        key: paymentProof,
        value: loginResponse.data!.user!.details!.paymentProof ?? '');
    await SharedPreferenceHelper()
        .setString(key: filePath, value: loginResponse.data!.filePath ?? '');
  }
}

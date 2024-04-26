import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/screens/common/login_screen.dart';
import 'package:rspsa_user/screens/student_portal/repository/student_signup_repository.dart';

class StudentSignupController extends GetxController {
  var emailController = TextEditingController().obs;
  var mobileController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;

  var addressController = TextEditingController().obs;
  var aadharController = TextEditingController().obs;

  var schoolNameController = TextEditingController().obs;
  var schoolAddressController = TextEditingController().obs;
  var appearingClassController = TextEditingController().obs;
  var accountNumberController = TextEditingController().obs;
  var bankNameController = TextEditingController().obs;
  var accountHolderNameController = TextEditingController().obs;
  var ifscCodeController = TextEditingController().obs;
  var utrController = TextEditingController().obs;
  var utrNumberController = TextEditingController().obs;
  var declarationController = TextEditingController().obs;
  var agree = false.obs;

  var registrationForController = TextEditingController().obs;
  var nameController = TextEditingController().obs;
  var sdcoController = TextEditingController().obs;
  var visiblePass = false.obs;
  var visibleConfirmPass = false.obs;
  var selectedOption = 0.obs;
  var selectedValue = "Select".obs;

  var isLoginCompeleted = false.obs;

  var talentList = [].obs;
  var programList = [].obs;
  var talentDetailsList = [].obs;

  List<String> appearingClasss = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];

  Future<void> getTalentList() async {
    try {
      EasyLoading.show();
      var response = await StudentSignupRepository().getTalentList();
      EasyLoading.dismiss();
      talentList.value = response.data!;
      log('programCategoryList len : ${talentList.length}');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error form getProgramCategoryList: $e');
    }
  }

  Future<void> getProgramList({required String talentId}) async {
    programList.clear();
    try {
      EasyLoading.show();
      var response =
          await StudentSignupRepository().getProgramList(talentId: talentId);
      EasyLoading.dismiss();
      programList.value = response.data!;
      log('program list len : ${programList.length}');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error form getProgramList: $e');
    }
  }

  Future<void> getTalentDetailsList({required String talentId}) async {
    talentDetailsList.clear();
    try {
      EasyLoading.show();
      var response = await StudentSignupRepository()
          .getTalentDetailsList(talentId: talentId);
      EasyLoading.dismiss();
      talentDetailsList.value = response.data!;
      log('talent details list len : ${talentDetailsList.length}');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error form getTalentDetailsList: $e');
    }
  }

  Future<void> studentSignup({
    required String talentId,
    required String programId,
    required String talentDetailsId,
    required String name,
    required String fatherName,
    required String email,
    required String mobile,
    required String dob,
    required String password,
    required String address,
    required String aadharNumber,
    required String schoolOrInstitutionName,
    required String schoolOrInstitutionAddress,
    required String appearingClass,
    required String bankName,
    required String accountHolderName,
    required String accountNumber,
    required String ifscCode,
    required String utrNo,
    required String declaration,
    required String termsAndConditions,
    required String registrationFor,
    required String? currentEducationProof,
    required String? photo,
    required String? signature,
    required String? paymentProof,
    required String? aadharCard,
  }) async {
    // try {
    EasyLoading.show();
    var response = await StudentSignupRepository().studentSignup(
        talentId: talentId,
        programId: programId,
        talentDetailsId: talentDetailsId,
        name: name,
        fatherName: fatherName,
        email: email,
        mobile: mobile,
        dob: dob,
        password: password,
        address: address,
        aadharNumber: aadharNumber,
        schoolOrInstitutionName: schoolOrInstitutionName,
        schoolOrInstitutionAddress: schoolOrInstitutionAddress,
        appearingClass: appearingClass,
        bankName: bankName,
        accountHolderName: accountHolderName,
        accountNumber: accountNumber,
        ifscCode: ifscCode,
        utrNo: utrNo,
        declaration: declaration,
        termsAndConditions: termsAndConditions,
        registrationFor: registrationFor,
        currentEducationProof: currentEducationProof,
        photo: photo,
        signature: signature,
        paymentProof: paymentProof,
        aadharCard: aadharCard);
    if (response!.status!) {
      EasyLoading.dismiss();
      EasyLoading.showToast('Signup Successfull',
          duration: const Duration(seconds: 2));
      Get.off(() => const LoginScreen());
    } else {
      EasyLoading.dismiss();
      EasyLoading.showToast('Signup Failed',
          duration: const Duration(seconds: 2));
    }
    // } catch (e) {
    //   EasyLoading.dismiss();
    //   EasyLoading.showToast('Something went wrong',
    //       duration: const Duration(seconds: 2));
    //   log('Error from studentSignup: $e');
    // }
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rspsa_user/screens/teacher_portal/repository/teacher_repository.dart';
import 'package:rspsa_user/utils/constants.dart';

class TeacherLoginController extends GetxController {
  var emailController = TextEditingController().obs;
  var mobileController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;

  var addressController = TextEditingController().obs;
  var aadharController = TextEditingController().obs;

  var degreeController = TextEditingController().obs;
  var passingYearController = TextEditingController().obs;
  var totalMarksController = TextEditingController().obs;
  var obtainedController = TextEditingController().obs;
  var percentageController = TextEditingController().obs;
  var schoolNameController = TextEditingController().obs;
  var experienceController = TextEditingController().obs;
  var agree = false.obs;

  var registrationForController = TextEditingController().obs;
  var nameController = TextEditingController().obs;
  var sdwoController = TextEditingController().obs;
  var visiblepass = false.obs;
  var selectedOption = 0.obs;
  var selectedValue = "Select".obs;
  var signaturePath = "".obs;
  var photoPath = "".obs;
  var schoolPhotoPath = "".obs;
  var adharCardPath = "".obs;

  File? adhar;
  File? photo;
  File? signature;
  File? school;

  var dob=''.obs;

var submitting=false.obs;
  Future<void> submitTeacherDetails() async {
    submitting.value = true;
    print(dob.value);
      await TeacherRepository().submitTeacherDetails(
        name: nameController.value.text,
        s_d_w_o: sdwoController.value.text,
        email: emailController.value.text,
        mobile: mobileController.value.text,
        dob: dob.value,
        address: addressController.value.text,
        password: passwordController.value.text,
        degree: degreeController.value.text,
        passingYear: passingYearController.value.text,
        totalMarks: totalMarksController.value.text,
        obtainedMarks: obtainedController.value.text,
        percentage: percentageController.value.text,
        teachingSchoolName: schoolNameController.value.text,
        experience: experienceController.value.text,
        teachingSchoolAddress: schoolOrInstututionAddress,
        adharCardPath: adharCardPath.value,
        photoPath: photoPath.value,
        signaturePath: signaturePath.value,
        schoolPhotoPath: schoolPhotoPath.value,
      );
    submitting.value = false;
  }
  Future<String?> pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      return image.path;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
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

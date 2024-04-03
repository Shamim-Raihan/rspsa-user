import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

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
}

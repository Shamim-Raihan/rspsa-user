import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class EmployeeController extends GetxController {
  var emailController = TextEditingController().obs;
  var mobileController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var designationController = TextEditingController().obs;
  var workingAreaController = TextEditingController().obs;

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

  var passingYearController = TextEditingController().obs;
  var totalMarksController = TextEditingController().obs;
  var obtainedController = TextEditingController().obs;
  var percentageController = TextEditingController().obs;
}

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;


  var registrationForController = TextEditingController().obs;
  var nameController = TextEditingController().obs;
  var sdcoController = TextEditingController().obs;
  var visiblepass = false.obs;
  var selectedOption = 0.obs;
  var selectedValue = "Select".obs;
}
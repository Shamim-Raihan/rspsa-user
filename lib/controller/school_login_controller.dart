import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SchoolLoginController extends GetxController {
  var schoolRegistrationNumberController = TextEditingController().obs;
  var schoolEmailIdController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;

  var schooladdressController = TextEditingController().obs;
  var schooldireactorNameController = TextEditingController().obs;
  var direactorContactNumberController = TextEditingController().obs;
  var totalStudentController = TextEditingController().obs;
  var totalTeacherController = TextEditingController().obs;

  var schoolNameController = TextEditingController().obs;
  var schoolMobileController = TextEditingController().obs;
  var visiblepass = false.obs;
}

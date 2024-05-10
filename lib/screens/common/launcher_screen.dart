import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/controller/login_controller.dart';

class LauncherScreen extends StatelessWidget {
  LauncherScreen({super.key});

  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

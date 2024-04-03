import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:rspsa_user/controller/login_controller.dart';
import 'package:rspsa_user/screens/login_screen.dart';
import 'package:rspsa_user/screens/teacher_portal/teacherLoginScreen.dart';
import 'package:rspsa_user/utils/color_helper.dart';
import 'package:rspsa_user/utils/space_helper.dart';
import 'package:rspsa_user/utils/text_style.dart';

class AccountSelectScreen extends StatelessWidget {
  AccountSelectScreen({super.key});
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 120.h,
            padding: const EdgeInsets.only(top: 50),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: ColorHelper.primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Center(
              child: Text('Account Type', style: FontStyles().normalTextWhite),
            ),
          ),
          SpaceHelper().verticalSpace30,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      loginController.selectedOption.value = 1;
                      Get.to(() => const LoginScreen());
                    },
                    child: buildCard(
                        icon: Icons.people,
                        title: "Student",
                        backgroundColor: ColorHelper.cardColor1),
                  ),
                ),
                SpaceHelper().horizoantalSpace15,
                Expanded(
                  child: InkWell(
                    onTap: () {
                      loginController.selectedOption.value = 2;
                      Get.to(() => const TeacherLoginScreen());
                    },
                    child: buildCard(
                        icon: Icons.people,
                        title: "Teacher",
                        backgroundColor: ColorHelper.cardColor2),
                  ),
                )
              ],
            ),
          ),
          SpaceHelper().verticalSpace15,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      loginController.selectedOption.value = 3;
                      Get.to(() => const LoginScreen());
                    },
                    child: buildCard(
                        icon: Icons.people,
                        title: "School",
                        backgroundColor: ColorHelper.cardColor3),
                  ),
                ),
                //  Spacer(),
                SpaceHelper().horizoantalSpace15,
                Expanded(
                  child: InkWell(
                    onTap: () {
                      loginController.selectedOption.value = 4;
                      Get.to(() => const LoginScreen());
                    },
                    child: buildCard(
                        icon: Icons.people,
                        title: "Employee",
                        backgroundColor: ColorHelper.cardColor4),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildCard(
      {required IconData icon,
      required String title,
      required Color backgroundColor}) {
    return Container(
      height: 110.h,
      // width: 110.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 40.sp,
          ),
          Text(
            title,
            style: FontStyles().normalTextWhite20,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/screens/teacher_portal/controller/teacher_controller.dart';
import 'package:rspsa_user/screens/teacher_portal/teacherSignupScreen.dart';
import 'package:rspsa_user/screens/teacher_portal/teacher_home_screen.dart';
import 'package:rspsa_user/utils/color_helper.dart';
import 'package:rspsa_user/utils/space_helper.dart';
import 'package:rspsa_user/utils/text_style.dart';

class TeacherLoginScreen extends StatefulWidget {
  const TeacherLoginScreen({super.key});

  @override
  State<TeacherLoginScreen> createState() => _TeacherLoginScreenState();
}

class _TeacherLoginScreenState extends State<TeacherLoginScreen> {
  @override
  Widget build(BuildContext context) {
    TeacherLoginController teacherLoginController =
        Get.put(TeacherLoginController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 200.h,
                    decoration: const BoxDecoration(
                        // color: Color.fromARGB(255, 229, 125, 118),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('images/logo.png')),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  children: [
                    Text(
                      "Hello! let's get started",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Sign in to continue.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    buildInputAndActionView(teacherLoginController, context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildInputAndActionView(
      TeacherLoginController teacherLoginController, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.h,
            child: TextField(
              controller: teacherLoginController.emailController.value,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorHelper.primaryColor, width: 1.2)),
                suffixIcon: const Icon(Icons.mail_outline,
                    color: ColorHelper.primaryColor),
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1.2)),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.2)),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 50.h,
            child: TextFormField(
              controller: teacherLoginController.passwordController.value,
              obscureText: !teacherLoginController.visiblepass.value,
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorHelper.primaryColor, width: 1.2)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.2)),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.2)),
                  suffixIcon: teacherLoginController.visiblepass.value
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              teacherLoginController.visiblepass.value
                                  ? teacherLoginController.visiblepass.value =
                                      false
                                  : teacherLoginController.visiblepass.value =
                                      true;
                            });
                          },
                          icon: const Icon(Icons.visibility,
                              color: ColorHelper.primaryColor))
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              teacherLoginController.visiblepass.value
                                  ? teacherLoginController.visiblepass.value =
                                      false
                                  : teacherLoginController.visiblepass.value =
                                      true;
                            });
                          },
                          icon: const Icon(
                            Icons.visibility_off,
                            color: ColorHelper.primaryColor,
                          )),
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.black)),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorHelper.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100), // <-- Radius
                ),
              ),
              onPressed: () {
                Get.to(TeacherHomeScreen());
              },
              child: Text(
                'SIGN IN',
                style: TextStyle(color: Colors.white, fontSize: 18.h),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: ColorHelper.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    decorationThickness: 1,
                    decorationStyle: TextDecorationStyle.solid,
                    fontSize: 14.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Do not have an account'),
              SpaceHelper().horizoantalSpace5,
              InkWell(
                onTap: () {
                  Get.to(TeacherSignupScreen());
                  // if (tloginController.selectedOption.value == 1) {
                  //   Get.off(() => const StudentSignupScreen());
                  // }
                  // if (loginController.selectedOption.value == 2) {
                  //   Get.off(() => const TeacherSignupScreen());
                  // }
                  // if (loginController.selectedOption.value == 3) {
                  //   Get.off(() => const StudentSignupScreen());
                  // }
                  // if (loginController.selectedOption.value == 4) {
                  //   Get.off(() => const StudentSignupScreen());
                  // }
                },
                child: Text(
                  'Sign Up',
                  style: FontStyles().normalTextRed,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}

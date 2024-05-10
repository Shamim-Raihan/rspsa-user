import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/controller/signup_controller.dart';
import 'package:rspsa_user/screens/common/login_screen.dart';

import '../../utils/color_helper.dart';
import '../../utils/space_helper.dart';
import '../../utils/text_style.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Sign Up to continue.",
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
                  buildInputAndActionView(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildInputAndActionView(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.h,
              child: TextField(
                controller: signupController.nameController.value,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorHelper.primaryColor, width: 1.2)),
                  suffixIcon: const Icon(Icons.mail_outline,
                      color: ColorHelper.primaryColor),
                  labelText: 'Name',
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
              child: TextField(
                controller: signupController.emailController.value,
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
                controller: signupController.passwordController.value,
                obscureText: signupController.passwordObscure.value,
                decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorHelper.primaryColor, width: 1.2)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.shade300, width: 1.2)),
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.2)),
                    suffixIcon: signupController.passwordObscure.value
                        ? IconButton(
                            onPressed: () {
                              signupController.passwordObscure.value =
                                  !signupController.passwordObscure.value;
                            },
                            icon: const Icon(Icons.visibility,
                                color: ColorHelper.primaryColor))
                        : IconButton(
                            onPressed: () {
                              signupController.passwordObscure.value =
                                  !signupController.passwordObscure.value;
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
              height: 50.h,
              child: TextFormField(
                controller: signupController.confirmPasswordController.value,
                obscureText: signupController.confirmPasswordObscure.value,
                decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorHelper.primaryColor, width: 1.2)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.shade300, width: 1.2)),
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.2)),
                    suffixIcon: signupController.confirmPasswordObscure.value
                        ? IconButton(
                            onPressed: () {
                              signupController.confirmPasswordObscure.value =
                                  !signupController
                                      .confirmPasswordObscure.value;
                            },
                            icon: const Icon(Icons.visibility,
                                color: ColorHelper.primaryColor))
                        : IconButton(
                            onPressed: () {
                              signupController.confirmPasswordObscure.value =
                                  !signupController
                                      .confirmPasswordObscure.value;
                            },
                            icon: const Icon(
                              Icons.visibility_off,
                              color: ColorHelper.primaryColor,
                            )),
                    labelText: 'Confirm Password',
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
                  // signupController.login();
                  if (signupController.nameController.value.text == '') {
                    EasyLoading.showToast('Enter Name');
                  }
                  if (signupController.emailController.value.text == '') {
                    EasyLoading.showToast('Enter Email');
                  }
                  if (signupController.passwordController.value.text == '') {
                    EasyLoading.showToast('Enter Password');
                  }
                  if (signupController.passwordController.value.text.length <
                      6) {
                    EasyLoading.showToast('Password length should be 6');
                  }
                  if (signupController.passwordController.value.text !=
                      signupController.confirmPasswordController.value.text) {
                    EasyLoading.showToast('Password does not match'); 
                  } else {
                    signupController.isSignup.value = true;
                    signupController.singup();
                  }
                },
                child: Text(
                  'SIGN UP',
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
                const Text('Already have an account'),
                SpaceHelper().horizoantalSpace5,
                InkWell(
                  onTap: () async {
                    Get.off(() => const LoginScreen());
                  },
                  child: Text(
                    'Sign In',
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
      ),
    );
  }
}

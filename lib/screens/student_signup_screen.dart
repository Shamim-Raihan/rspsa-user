import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:rspsa_user/controller/login_controller.dart';
import 'package:rspsa_user/custom_widget.dart/cusotm_text_field.dart';
import 'package:rspsa_user/screens/login_screen.dart';
import 'package:rspsa_user/utils/color_helper.dart';
import 'package:rspsa_user/utils/space_helper.dart';
import 'package:rspsa_user/utils/text_style.dart';

class StudentSignupScreen extends StatefulWidget {
  const StudentSignupScreen({super.key});

  @override
  State<StudentSignupScreen> createState() => _StudentSignupScreenState();
}

class _StudentSignupScreenState extends State<StudentSignupScreen> {
  String? _dropDownValue;
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
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
                Column(
                  children: [
                    Text(
                      "Create New Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    buildInputAndActionView(loginController, context),
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
      LoginController loginController, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select program',
            style: FontStyles().largeTextRed,
          ),
          SpaceHelper().verticalSpace10,
          Container(
            height: 50.h,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(5)),
            child: DropdownButton(
              underline: const SizedBox(),
              hint: _dropDownValue == null
                  ? const Text('Select Program')
                  : Text(
                      _dropDownValue!,
                      style: FontStyles().normalTextBlack,
                    ),
              isExpanded: true,
              iconSize: 30.0,
              style: const TextStyle(color: Colors.blue),
              items: ['Program 1', 'Program 1', 'Program 1'].map(
                (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(
                      val,
                      style: FontStyles().normalTextBlack,
                    ),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                  () {
                    _dropDownValue = val;
                  },
                );
              },
            ),
          ),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: loginController.registrationForController.value,
              levelText: "Registration For", suffixIcon: Icons.app_registration),
          SpaceHelper().verticalSpace20,
          Text(
            'Student Profile',
            style: FontStyles().largeTextRed,
          ),
           SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: loginController.nameController.value,
              levelText: "Student Name",
              suffixIcon: Icons.person_2_outlined
              ),
              SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: loginController.sdcoController.value,
              levelText: "S/D/C/o",
              suffixIcon: Icons.person_2_outlined
              ),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: loginController.emailController.value,
              levelText: "Email",
              suffixIcon: Icons.mail_outline
              ),
          SpaceHelper().verticalSpace10,
          SizedBox(
            height: 50.h,
            child: TextFormField(
              controller: loginController.passwordController.value,
              obscureText: !loginController.visiblepass.value,
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorHelper.primaryColor, width: 1.2)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.2)),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.2)),
                  suffixIcon: loginController.visiblepass.value
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              loginController.visiblepass.value
                                  ? loginController.visiblepass.value = false
                                  : loginController.visiblepass.value = true;
                            });
                          },
                          icon: const Icon(Icons.visibility,
                              color: ColorHelper.primaryColor))
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              loginController.visiblepass.value
                                  ? loginController.visiblepass.value = false
                                  : loginController.visiblepass.value = true;
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
                // Get.offAll(() => AdminLandingScreen());
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
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account'),
              SpaceHelper().horizoantalSpace5,
              InkWell(
                onTap: () {
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
    );
  }
}

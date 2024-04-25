import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/screens/common/login_screen.dart';
import 'package:rspsa_user/screens/school_portal/controller/school_login_controller.dart';
import 'package:rspsa_user/custom_widget.dart/cusotm_text_field.dart';
import 'package:rspsa_user/utils/color_helper.dart';
import 'package:rspsa_user/utils/space_helper.dart';
import 'package:rspsa_user/utils/text_style.dart';

class SchoolSignUpScreen extends StatefulWidget {
  const SchoolSignUpScreen({super.key});

  @override
  State<SchoolSignUpScreen> createState() => _SchoolSignUpScreenState();
}

class _SchoolSignUpScreenState extends State<SchoolSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    SchoolLoginController schoolLoginController =
        Get.put(SchoolLoginController());
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
                    buildInputAndActionView(schoolLoginController, context),
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
      SchoolLoginController schoolLoginController, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Teacher Profile',
          //   style: FontStyles().largeTextRed,
          // ),
          // SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: schoolLoginController.schoolNameController.value,
              levelText: "School Name",
              suffixIcon: Icons.person_2_outlined),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: schoolLoginController
                  .schoolRegistrationNumberController.value,
              levelText: "School Registration Number",
              suffixIcon: Icons.numbers),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: schoolLoginController.schoolEmailIdController.value,
              levelText: "School Email ID",
              suffixIcon: Icons.mail_outline),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: schoolLoginController.schoolMobileController.value,
              levelText: "School Mobile Number",
              suffixIcon: Icons.phone),
          SpaceHelper().verticalSpace10,

          CustomTextField().textField(
              controller: schoolLoginController.schooladdressController.value,
              levelText: "School Address",
              suffixIcon: Icons.location_on),
          SpaceHelper().verticalSpace10,
          SizedBox(
            height: 50.h,
            child: TextFormField(
              controller: schoolLoginController.passwordController.value,
              obscureText: !schoolLoginController.visiblepass.value,
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorHelper.primaryColor, width: 1.2)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.2)),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.2)),
                  suffixIcon: schoolLoginController.visiblepass.value
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              schoolLoginController.visiblepass.value
                                  ? schoolLoginController.visiblepass.value =
                                      false
                                  : schoolLoginController.visiblepass.value =
                                      true;
                            });
                          },
                          icon: const Icon(Icons.visibility,
                              color: ColorHelper.primaryColor))
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              schoolLoginController.visiblepass.value
                                  ? schoolLoginController.visiblepass.value =
                                      false
                                  : schoolLoginController.visiblepass.value =
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
          SpaceHelper().verticalSpace10,
          SizedBox(
            height: 50.h,
            child: TextFormField(
              controller: schoolLoginController.conpasswordController.value,
              obscureText: !schoolLoginController.convisiblepass.value,
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorHelper.primaryColor, width: 1.2)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 1.2)),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.2)),
                  suffixIcon: schoolLoginController.convisiblepass.value
                      ? IconButton(
                      onPressed: () {
                        setState(() {
                          schoolLoginController.convisiblepass.value
                              ? schoolLoginController.convisiblepass.value =
                          false
                              : schoolLoginController.convisiblepass.value =
                          true;
                        });
                      },
                      icon: const Icon(Icons.visibility,
                          color: ColorHelper.primaryColor))
                      : IconButton(
                      onPressed: () {
                        setState(() {
                          schoolLoginController.convisiblepass.value
                              ? schoolLoginController.convisiblepass.value =
                          false
                              : schoolLoginController.convisiblepass.value =
                          true;
                        });
                      },
                      icon: const Icon(
                        Icons.visibility_off,
                        color: ColorHelper.primaryColor,
                      )),
                  labelText: 'Confirm Password',
                  labelStyle: const TextStyle(color: Colors.black)),
            ),
          ),
          SpaceHelper().verticalSpace10,

          CustomTextField().textField(
              controller:
                  schoolLoginController.schooldireactorNameController.value,
              levelText: "School Director Name",
              suffixIcon: Icons.person),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller:
                  schoolLoginController.direactorContactNumberController.value,
              levelText: "Director Contact Number",
              suffixIcon: Icons.call),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: schoolLoginController.totalStudentController.value,
              levelText: "Total Student",
              suffixIcon: Icons.class_),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: schoolLoginController.totalTeacherController.value,
              levelText: "Total Teacher",
              suffixIcon: Icons.class_),

          SizedBox(
            height: 30.h,
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
              onPressed: () async{
                if (schoolLoginController.schoolNameController.value.text.isEmpty ||
                    schoolLoginController.schoolRegistrationNumberController.value.text.isEmpty ||
                    schoolLoginController.schoolEmailIdController.value.text.isEmpty ||
                    schoolLoginController.schoolMobileController.value.text.isEmpty ||
                    schoolLoginController.passwordController.value.text.isEmpty ||
                    schoolLoginController.schooladdressController.value.text.isEmpty ||
                    schoolLoginController.schooldireactorNameController.value.text.isEmpty ||
                    schoolLoginController.direactorContactNumberController.value.text.isEmpty ||
                    schoolLoginController.totalStudentController.value.text.isEmpty ||
                    schoolLoginController.totalTeacherController.value.text.isEmpty ||
                    schoolLoginController.schoolNameController.value.text == "" ||
                    schoolLoginController.schoolRegistrationNumberController.value.text == "" ||
                    schoolLoginController.schoolEmailIdController.value.text == "" ||
                    schoolLoginController.schoolMobileController.value.text == "" ||
                    schoolLoginController.passwordController.value.text == "" ||
                    schoolLoginController.schooladdressController.value.text == "" ||
                    schoolLoginController.schooldireactorNameController.value.text == "" ||
                    schoolLoginController.direactorContactNumberController.value.text == "" ||
                    schoolLoginController.totalStudentController.value.text == "" ||
                    schoolLoginController.totalTeacherController.value.text == "") {
                  Fluttertoast.showToast(
                    msg: 'Please fill in all required fields',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }

                else if(schoolLoginController.schoolMobileController.value.text.length<10 || schoolLoginController.direactorContactNumberController.value.text.length<10)
                  {
                    Fluttertoast.showToast(
                      msg: 'The mobile field must be 10 digits.',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                else if(schoolLoginController.isPasswordValid(schoolLoginController.passwordController.value.text)==false)
                {
                  Fluttertoast.showToast(
                    msg: "The password field must be at least 10 characters.\nPassword should contain upper case, lower case, numbers and special characters",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }

                else if(schoolLoginController.isEmailValid(schoolLoginController.schoolEmailIdController.value.text)==false){
                  Fluttertoast.showToast(
                    msg: 'Insert a valid email.',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }

                else if(schoolLoginController.passwordController.value.text!=schoolLoginController.conpasswordController.value.text){
                  Fluttertoast.showToast(
                    msg: 'Please make sure your password match .',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }

                else{
                  await schoolLoginController.createSchool();
                   Get.offAll(() => LoginScreen());
                }

              },
              child: Obx(()=>schoolLoginController.submitting.value?
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("images/img.gif"),
              ):
              Text(
                'SIGN UP',
                style: TextStyle(color: Colors.white, fontSize: 18.h),
              ),)
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
                onTap: () {},
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

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rspsa_user/controller/school_login_controller.dart';
import 'package:rspsa_user/custom_widget.dart/cusotm_text_field.dart';
import 'package:rspsa_user/utils/color_helper.dart';
import 'package:rspsa_user/utils/space_helper.dart';
import 'package:rspsa_user/utils/text_style.dart';

class SchoolProfileScreen extends StatefulWidget {
  const SchoolProfileScreen({super.key});

  @override
  State<SchoolProfileScreen> createState() => _SchoolProfileScreenState();
}

class _SchoolProfileScreenState extends State<SchoolProfileScreen> {
  final sDateFormate = "dd/MM/yyyy";
  DateTime _dateTime = DateTime.now();
  bool isDateSelected = false;
  bool agreeToTerms = false;
  File? _file;
  PlatformFile? _platformFile;

  selectFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (file != null) {
      setState(() {
        _file = File(file.files.single.path!);
        _platformFile = file.files.first;
      });
    }
  }

  String? _filePath;

  void _openFileExplorer() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        String? filePath = result.files.single.path;
        if (filePath != null) {
          setState(() {
            _filePath = filePath;
          });
        } else {
          if (kDebugMode) {
            print("No file selected");
          }
        }
      } else {
        if (kDebugMode) {
          print("User canceled the file picker");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error picking file: $e");
      }
    }
  }

  String? _dropDownValue;
  void _showCupertinoDatePicker() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: const Color(0xFF5F8B95),
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  )),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _dateTime ?? DateTime.now(),
                  minimumDate: DateTime(1900),
                  maximumDate: DateTime(2025),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _dateTime = newDate;
                      isDateSelected = true;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime dateTime) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  String _imagePath = '';
  @override
  Widget build(BuildContext context) {
    SchoolLoginController schoolLoginController =
        Get.put(SchoolLoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // automaticallyImplyLeading: false,
        title: Text(
          'Edit Profile',
          style: TextStyle(fontSize: 16.sp),
        ),
        centerTitle: true,
        elevation: 0,
      ),
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
          Center(
            child: Stack(
              children: [
                Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(
                        width: 3,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFE7E9EB),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(Icons.person),
                  ),
                ),
                Positioned(
                    bottom: 10.h,
                    right: 2.w,
                    child: const CircleAvatar(
                        backgroundColor: Color(0xffe7e9eb),
                        child: Icon(Icons.edit)))
              ],
            ),
          ),
          CustomTextField().textField(
              controller: schoolLoginController.schoolEmailIdController.value,
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

          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(200.w, 40.h)),
                backgroundColor:
                    MaterialStateProperty.all(ColorHelper.primaryColor),
              ),
              onPressed: () {},
              child: Text(
                'Update Profile',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}

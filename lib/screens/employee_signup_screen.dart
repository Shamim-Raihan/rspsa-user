import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rspsa_user/controller/employee_controller.dart';
import 'package:rspsa_user/custom_widget.dart/cusotm_text_field.dart';
import 'package:rspsa_user/utils/color_helper.dart';
import 'package:rspsa_user/utils/space_helper.dart';
import 'package:rspsa_user/utils/text_style.dart';

class EmployeeSignUpScreen extends StatefulWidget {
  const EmployeeSignUpScreen({super.key});

  @override
  State<EmployeeSignUpScreen> createState() => _EmployeeSignUpScreenState();
}

class _EmployeeSignUpScreenState extends State<EmployeeSignUpScreen> {
  final sDateFormate = "dd/MM/yyyy";
  DateTime _dateTime = DateTime.now();
  bool isDateSelected = false;
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
          print("No file selected");
        }
      } else {
        print("User canceled the file picker");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

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
                      color: Color(0xFF5F8B95),
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

  @override
  Widget build(BuildContext context) {
    EmployeeController employeeController = Get.put(EmployeeController());
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
                    buildInputAndActionView(employeeController, context),
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
      EmployeeController employeeController, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Employee Profile',
            style: FontStyles().largeTextRed,
          ),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: employeeController.nameController.value,
              levelText: "Employee Name",
              suffixIcon: Icons.person_2_outlined),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: employeeController.sdcoController.value,
              levelText: "S/D/C/o",
              suffixIcon: Icons.numbers_rounded),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: employeeController.emailController.value,
              levelText: "Email ID",
              suffixIcon: Icons.mail_outline),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: employeeController.mobileController.value,
              levelText: "Mobile",
              suffixIcon: Icons.phone),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: employeeController.designationController.value,
              levelText: "Designation",
              suffixIcon: Icons.work),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: employeeController.workingAreaController.value,
              levelText: "Working Area",
              suffixIcon: Icons.location_on),
          SpaceHelper().verticalSpace10,
          GestureDetector(
            onTap: _showCupertinoDatePicker,
            child: Container(
              // margin: EdgeInsets.only(top: 15.h),
              // width: 313.w,
              height: 50.h,
              padding: EdgeInsets.only(top: 4.h, left: 16.w, bottom: 4.h),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade300, width: 1.2),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isDateSelected ? _formatDate(_dateTime) : 'Date of Birth',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Icon(
                        Icons.calendar_month,
                        color: ColorHelper.primaryColor,
                      ))
                ],
              ),
            ),
          ),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: employeeController.addressController.value,
              levelText: "Full Address",
              suffixIcon: Icons.location_on),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: employeeController.aadharController.value,
              levelText: "Aadhar Number",
              suffixIcon: Icons.numbers),
          SpaceHelper().verticalSpace10,
          SizedBox(
            height: 50.h,
            child: TextFormField(
              controller: employeeController.passwordController.value,
              obscureText: !employeeController.visiblepass.value,
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorHelper.primaryColor, width: 1.2)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.2)),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.2)),
                  suffixIcon: employeeController.visiblepass.value
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              employeeController.visiblepass.value
                                  ? employeeController.visiblepass.value = false
                                  : employeeController.visiblepass.value = true;
                            });
                          },
                          icon: const Icon(Icons.visibility,
                              color: ColorHelper.primaryColor))
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              employeeController.visiblepass.value
                                  ? employeeController.visiblepass.value = false
                                  : employeeController.visiblepass.value = true;
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
          Text(
            'Education Details',
            style: FontStyles().largeTextRed,
          ),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: employeeController.schoolNameController.value,
              levelText: "School/Institution Name",
              suffixIcon: Icons.school),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: employeeController.addressController.value,
              levelText: "School/Institution Addreess",
              suffixIcon: Icons.location_on),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: employeeController.appearingClassController.value,
              levelText: "Appearing Class",
              suffixIcon: Icons.class_),
          SpaceHelper().verticalSpace10,
          Text(
            'Bank Details',
            style: FontStyles().largeTextRed,
          ),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: employeeController.accountNumberController.value,
              levelText: "Account Number",
              suffixIcon: Icons.numbers),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: employeeController.ifscCodeController.value,
              levelText: "IFSC Code",
              suffixIcon: Icons.table_restaurant_rounded),
          SpaceHelper().verticalSpace10,
          Text(
            'Upload Documents',
            style: FontStyles().largeTextRed,
          ),
          SpaceHelper().verticalSpace10,
          Container(
            height: 50.h,
            padding: EdgeInsets.only(top: 4.h, left: 16.w, bottom: 4.h),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300, width: 1.2),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Aadhar Card'),
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: ElevatedButton(
                    onPressed: _openFileExplorer,
                    child: Text('Upload File'),
                  ),
                ),
              ],
            ),
          ),
          SpaceHelper().verticalSpace10,
          Container(
            height: 50.h,
            padding: EdgeInsets.only(top: 4.h, left: 16.w, bottom: 4.h),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300, width: 1.2),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Photo'),
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: ElevatedButton(
                    onPressed: _openFileExplorer,
                    child: Text('Upload File'),
                  ),
                ),
              ],
            ),
          ),
          SpaceHelper().verticalSpace10,
          Container(
            height: 50.h,
            padding: EdgeInsets.only(top: 4.h, left: 16.w, bottom: 4.h),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300, width: 1.2),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Signature'),
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: ElevatedButton(
                    onPressed: _openFileExplorer,
                    child: Text('Upload File'),
                  ),
                ),
              ],
            ),
          ),
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
              onPressed: () {},
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

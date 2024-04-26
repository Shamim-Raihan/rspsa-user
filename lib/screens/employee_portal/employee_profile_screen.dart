import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rspsa_user/screens/employee_portal/controller/employee_controller.dart';
import 'package:rspsa_user/custom_widget.dart/cusotm_text_field.dart';
import 'package:rspsa_user/utils/color_helper.dart';
import 'package:rspsa_user/utils/space_helper.dart';
import 'package:rspsa_user/utils/text_style.dart';

class EmployeeProfileScreen extends StatefulWidget {
  const EmployeeProfileScreen({super.key});

  @override
  State<EmployeeProfileScreen> createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  EmployeeController employeeController = Get.put(EmployeeController());
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
    EmployeeController employeeController = Get.put(EmployeeController());
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
              Column(
                children: [
                  buildInputAndActionView(employeeController, context),
                ],
              ),
            ],
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
                      child: const Icon(
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
                const Text('Aadhar Card'),
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: ElevatedButton(
                    onPressed: _openFileExplorer,
                    child: const Text('Upload File'),
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
                const Text('Photo'),
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: ElevatedButton(
                    onPressed: _openFileExplorer,
                    child: const Text('Upload File'),
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
                const Text('Signature'),
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: ElevatedButton(
                    onPressed: _openFileExplorer,
                    child: const Text('Upload File'),
                  ),
                ),
              ],
            ),
          ),
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

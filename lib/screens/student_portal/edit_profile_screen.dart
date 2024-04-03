import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rspsa_user/custom_widget.dart/cusotm_text_field.dart';
import 'package:rspsa_user/screens/common/login_screen.dart';
import 'package:rspsa_user/screens/student_portal/controller/studentController.dart';
import 'package:rspsa_user/utils/color_helper.dart';
import 'package:rspsa_user/utils/space_helper.dart';
import 'package:rspsa_user/utils/text_style.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  StudentController studentController = Get.put(StudentController());
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
    StudentController studentController = Get.put(StudentController());
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
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
                  controller: studentController.registrationForController.value,
                  levelText: "Registration For",
                  suffixIcon: Icons.app_registration),
              SpaceHelper().verticalSpace20,
              Text(
                'Student Profile',
                style: FontStyles().largeTextRed,
              ),
              SpaceHelper().verticalSpace10,
              CustomTextField().textField(
                  controller: studentController.nameController.value,
                  levelText: "Student Name",
                  suffixIcon: Icons.person_2_outlined),
              SpaceHelper().verticalSpace10,
              CustomTextField().textField(
                  controller: studentController.sdcoController.value,
                  levelText: "S/D/C/o",
                  suffixIcon: Icons.person_2_outlined),
              SpaceHelper().verticalSpace10,
              CustomTextField().textField(
                  controller: studentController.emailController.value,
                  levelText: "Email",
                  suffixIcon: Icons.mail_outline),
              SpaceHelper().verticalSpace10,
              CustomTextField().textField(
                  controller: studentController.mobileController.value,
                  levelText: "Mobile",
                  suffixIcon: Icons.phone),
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
                        isDateSelected
                            ? _formatDate(_dateTime)
                            : 'Date of Birth',
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
                  controller: studentController.addressController.value,
                  levelText: "Full Address",
                  suffixIcon: Icons.location_on),
              SpaceHelper().verticalSpace10,
              CustomTextField().textField(
                  controller: studentController.aadharController.value,
                  levelText: "Aadhar Number",
                  suffixIcon: Icons.numbers),
              SpaceHelper().verticalSpace10,
              SizedBox(
                height: 50.h,
                child: TextFormField(
                  controller: studentController.passwordController.value,
                  obscureText: !studentController.visiblepass.value,
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
                      suffixIcon: studentController.visiblepass.value
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  studentController.visiblepass.value
                                      ? studentController.visiblepass.value =
                                          false
                                      : studentController.visiblepass.value =
                                          true;
                                });
                              },
                              icon: const Icon(Icons.visibility,
                                  color: ColorHelper.primaryColor))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  studentController.visiblepass.value
                                      ? studentController.visiblepass.value =
                                          false
                                      : studentController.visiblepass.value =
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
              Text(
                'Education Details',
                style: FontStyles().largeTextRed,
              ),
              SpaceHelper().verticalSpace10,
              CustomTextField().textField(
                  controller: studentController.schoolNameController.value,
                  levelText: "School/Institute Name",
                  suffixIcon: Icons.school),
              SpaceHelper().verticalSpace10,
              CustomTextField().textField(
                  controller: studentController.schoolAddressController.value,
                  levelText: "School/Institute Address",
                  suffixIcon: Icons.location_on),
              SpaceHelper().verticalSpace10,
              CustomTextField().textField(
                  controller: studentController.schoolAddressController.value,
                  levelText: "Appearing Class",
                  suffixIcon: Icons.class_),
              SpaceHelper().verticalSpace10,
              Text(
                'Bank Details',
                style: FontStyles().largeTextRed,
              ),
              SpaceHelper().verticalSpace10,
              CustomTextField().textField(
                  controller: studentController.accountNumberController.value,
                  levelText: "Account Number",
                  suffixIcon: Icons.balance),
              SpaceHelper().verticalSpace10,
              CustomTextField().textField(
                  controller: studentController.ifscCodeController.value,
                  levelText: "IFSC Code",
                  suffixIcon: Icons.pin_rounded),
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
                    const Text('Current Education Proof'),
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
                    const Text('Payment proof'),
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
                    const Text('UTR Number'),
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
              SizedBox(
                height: 50.h,
                child: TextField(
                  controller: studentController.declarationController.value,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorHelper.primaryColor, width: 1.2)),
                    suffixIcon: const Icon(Icons.description,
                        color: ColorHelper.primaryColor),
                    labelText: 'Declaration',
                    labelStyle: const TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.shade300, width: 1.2)),
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.2)),
                  ),
                ),
              ),
              SpaceHelper().verticalSpace5,
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(200.w, 40.h)),
                    backgroundColor:
                        MaterialStateProperty.all(ColorHelper.primaryColor),
                  ),
                  onPressed: _saveProfile,
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
        ),
      ),
    );
  }

  void _selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void _saveProfile() {
    String name = studentController.nameController.value.text;
    String mobile = studentController.mobileController.value.text;
    String address = studentController.addressController.value.text;

    // Print or use the values for demonstration purposes
    print('Name: $name');
    print('Mobile: $mobile');
    print('Address: $address');
    print('Image Path: $_imagePath');
  }

  @override
  void dispose() {
    studentController.nameController.value.dispose();
    studentController.mobileController.value.dispose();
    studentController.addressController.value.dispose();
    super.dispose();
  }
}

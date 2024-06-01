import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rspsa_user/controller/signup_controller.dart';
import 'package:rspsa_user/custom_widget.dart/cusotm_text_field.dart';
import 'package:rspsa_user/screens/common/login_screen.dart';
import 'package:rspsa_user/screens/student_portal/controller/student_controller.dart';
import 'package:rspsa_user/screens/teacher_portal/controller/teacher_controller.dart';
import 'package:rspsa_user/utils/color_helper.dart';
import 'package:rspsa_user/utils/space_helper.dart';
import 'package:rspsa_user/utils/text_style.dart';

import '../../utils/constants.dart';

class TeacherSignupScreen extends StatefulWidget {
  const TeacherSignupScreen({super.key});

  @override
  State<TeacherSignupScreen> createState() => _TeacherSignupScreenState();
}

class _TeacherSignupScreenState extends State<TeacherSignupScreen> {
  final sDateFormate = "dd/MM/yyyy";
  DateTime _dateTime = DateTime.now();
  bool isDateSelected = false;
  bool agreeToTerms = false;
  File? _file;
  PlatformFile? _platformFile;
  SignupController signupController = Get.put(SignupController());

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

  void openFileExplorer(String type) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        String? filePath = result.files.single.path;
        if (filePath != null) {
          setState(() {
            _filePath = filePath;
            print(_filePath.toString());

            if (type == "adharcard") {
              teacherLoginController.adharCardPath.value = _filePath!;
            } else if (type == "photo") {
              teacherLoginController.photoPath.value = _filePath.toString();
            } else if (type == "signature") {
              teacherLoginController.signaturePath.value = _filePath.toString();
            } else if (type == "school") {
              teacherLoginController.schoolPhotoPath.value =
                  _filePath.toString();
            }
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
                  initialDateTime: _dateTime,
                  minimumDate: DateTime(1900),
                  maximumDate: DateTime(2025),
                  onDateTimeChanged: (DateTime newDate) {
                    teacherLoginController.dob.value =
                        _formatDate(_dateTime).toString();
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
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  final List<String> _dropdownOptions = [
    'Education',
    'B.Tech.',
    'BSc',
    'MBA',
    'Engineering'
  ];
  String _selectedOption = 'Education';

  TeacherLoginController teacherLoginController =
      Get.put(TeacherLoginController());
  void _submitEducationDetails() {
    Map<String, String> educationData = {
      'option': _selectedOption,
      'passingYear': teacherLoginController.passingYearController.value.text,
      'totalMarks': teacherLoginController.totalMarksController.value.text,
      'obtainedMarks': teacherLoginController.obtainedController.value.text,
      'percentage': teacherLoginController.percentageController.value.text,
    };
    // print("Captured Education Data: ${educationData}");
    setState(() {
      teacherLoginController.educationDetails.add(educationData);
    });
    print("Captured Education Data: ${educationData}");
    Navigator.of(context).pop();
  }

  void _showEducationDetailsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: const Text('Add Education Details'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(28.r)),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: 50.h,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButton<String>(
                    underline: const SizedBox(),
                    value: _selectedOption,
                    items: _dropdownOptions
                        .map((option) => DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        teacherLoginController.degreeController.value.text =
                            _selectedOption!;
                        _selectedOption = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                _buildTextField(
                    teacherLoginController.passingYearController.value,
                    'Passing Year'),
                SizedBox(
                  height: 10.h,
                ),
                _buildTextField(
                    teacherLoginController.totalMarksController.value,
                    'Total Marks'),
                SizedBox(
                  height: 10.h,
                ),
                _buildTextField(teacherLoginController.obtainedController.value,
                    'Obtained Marks'),
                SizedBox(
                  height: 10.h,
                ),
                _buildTextField(
                    teacherLoginController.percentageController.value,
                    'Percentage'),
              ],
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 80.w,
                height: 35.h,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                    side: const BorderSide(
                        width: 1, color: Color.fromARGB(255, 195, 197, 197)),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Cancel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                backgroundColor:
                    MaterialStateProperty.all(ColorHelper.primaryColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(100), // Custom border radius
                  ),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(70.w, 30.h),
                ),
              ),
              onPressed: () {
                if (teacherLoginController
                        .degreeController.value.text.isEmpty ||
                    teacherLoginController
                        .passingYearController.value.text.isEmpty ||
                    teacherLoginController
                        .totalMarksController.value.text.isEmpty ||
                    teacherLoginController
                        .obtainedController.value.text.isEmpty ||
                    teacherLoginController
                        .percentageController.value.text.isEmpty ||
                    teacherLoginController.degreeController.value.text == "" ||
                    teacherLoginController.passingYearController.value.text ==
                        "" ||
                    teacherLoginController.totalMarksController.value == "" ||
                    teacherLoginController.obtainedController.value == "" ||
                    teacherLoginController.percentageController.value == "") {
                  Fluttertoast.showToast(
                    msg: 'Please fill in all required fields',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else {
                  _submitEducationDetails();
                }
              },
              child: Text(
                'Submit',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Container(
      height: 50.h,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TeacherLoginController teacherLoginController =
        Get.put(TeacherLoginController());
    teacherLoginController.nameController.value.text =
        signupController.nameController.value.text;
    teacherLoginController.emailController.value.text =
        signupController.emailController.value.text;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Teacher Profile',
            style: FontStyles().largeTextRed,
          ),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: teacherLoginController.nameController.value,
              levelText: "Teacher Name",
              suffixIcon: Icons.person_2_outlined,
              enabled: false),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: teacherLoginController.sdwoController.value,
              levelText: "S/D/W/o",
              suffixIcon: Icons.person_2_outlined),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: teacherLoginController.emailController.value,
              levelText: "Email ID",
              suffixIcon: Icons.mail_outline,
              enabled: false),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: teacherLoginController.mobileController.value,
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
              controller: teacherLoginController.addressController.value,
              levelText: "Full Address",
              suffixIcon: Icons.location_on),
          SpaceHelper().verticalSpace10,
          // SizedBox(
          //   height: 50.h,
          //   child: TextFormField(
          //     controller: teacherLoginController.passwordController.value,
          //     obscureText: !teacherLoginController.visiblepass.value,
          //     decoration: InputDecoration(
          //         focusedBorder: const OutlineInputBorder(
          //             borderSide: BorderSide(
          //                 color: ColorHelper.primaryColor, width: 1.2)),
          //         enabledBorder: OutlineInputBorder(
          //             borderSide:
          //                 BorderSide(color: Colors.grey.shade300, width: 1.2)),
          //         border: const OutlineInputBorder(
          //             borderSide: BorderSide(color: Colors.black, width: 1.2)),
          //         suffixIcon: teacherLoginController.visiblepass.value
          //             ? IconButton(
          //                 onPressed: () {
          //                   setState(() {
          //                     teacherLoginController.visiblepass.value
          //                         ? teacherLoginController.visiblepass.value =
          //                             false
          //                         : teacherLoginController.visiblepass.value =
          //                             true;
          //                   });
          //                 },
          //                 icon: const Icon(Icons.visibility,
          //                     color: ColorHelper.primaryColor))
          //             : IconButton(
          //                 onPressed: () {
          //                   setState(() {
          //                     teacherLoginController.visiblepass.value
          //                         ? teacherLoginController.visiblepass.value =
          //                             false
          //                         : teacherLoginController.visiblepass.value =
          //                             true;
          //                   });
          //                 },
          //                 icon: const Icon(
          //                   Icons.visibility_off,
          //                   color: ColorHelper.primaryColor,
          //                 )),
          //         labelText: 'Password',
          //         labelStyle: const TextStyle(color: Colors.black)),
          //   ),
          // ),
          // SpaceHelper().verticalSpace10,
          // SizedBox(
          //   height: 50.h,
          //   child: TextFormField(
          //     controller: teacherLoginController.conpasswordController.value,
          //     obscureText: !teacherLoginController.convisiblepass.value,
          //     decoration: InputDecoration(
          //         focusedBorder: const OutlineInputBorder(
          //             borderSide: BorderSide(
          //                 color: ColorHelper.primaryColor, width: 1.2)),
          //         enabledBorder: OutlineInputBorder(
          //             borderSide:
          //             BorderSide(color: Colors.grey.shade300, width: 1.2)),
          //         border: const OutlineInputBorder(
          //             borderSide: BorderSide(color: Colors.black, width: 1.2)),
          //         suffixIcon: teacherLoginController.convisiblepass.value
          //             ? IconButton(
          //             onPressed: () {
          //               setState(() {
          //                 teacherLoginController.convisiblepass.value
          //                     ? teacherLoginController.convisiblepass.value =
          //                 false
          //                     : teacherLoginController.convisiblepass.value =
          //                 true;
          //               });
          //             },
          //             icon: const Icon(Icons.visibility,
          //                 color: ColorHelper.primaryColor))
          //             : IconButton(
          //             onPressed: () {
          //               setState(() {
          //                 teacherLoginController.convisiblepass.value
          //                     ? teacherLoginController.convisiblepass.value =
          //                 false
          //                     : teacherLoginController.convisiblepass.value =
          //                 true;
          //               });
          //             },
          //             icon: const Icon(
          //               Icons.visibility_off,
          //               color: ColorHelper.primaryColor,
          //             )),
          //         labelText: 'Confirm Password',
          //         labelStyle: const TextStyle(color: Colors.black)),
          //   ),
          // ),
          // SpaceHelper().verticalSpace10,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Education Details',
                style: FontStyles().largeTextRed,
              ),
              const SizedBox(width: 8.0),
              InkWell(
                onTap: _showEducationDetailsDialog,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(Icons.add),
                ),
              ),
              // Display the submitted education details
            ],
          ),
          const SizedBox(height: 16.0),
          Column(
            children: teacherLoginController.educationDetails.map((details) {
              return _buildEducationDetailsSection(details);
            }).toList(),
          ),

          // for (Map<String, String> details in _educationDetails)
          //   Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Container(
          //         height: 50.h,
          //         padding: EdgeInsets.symmetric(horizontal: 10.w),
          //         decoration: BoxDecoration(
          //             border:
          //                 Border.all(color: Colors.grey.shade300, width: 1.2),
          //             borderRadius: BorderRadius.circular(5.r)),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Row(
          //               children: [
          //                 Text(
          //                   'Educatiuon: ',
          //                   style: TextStyle(
          //                       fontSize: 15.sp, fontWeight: FontWeight.w500),
          //                 ),
          //                 Text('${details['option']}')
          //               ],
          //             ),
          //             const Icon(
          //               Icons.school,
          //               color: ColorHelper.primaryColor,
          //             )
          //           ],
          //         ),
          //       ),
          //       SizedBox(
          //         height: 10.h,
          //       ),
          //       Container(
          //         height: 50.h,
          //         padding: EdgeInsets.symmetric(horizontal: 10.w),
          //         decoration: BoxDecoration(
          //             border:
          //                 Border.all(color: Colors.grey.shade300, width: 1.2),
          //             borderRadius: BorderRadius.circular(5.r)),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Row(
          //               children: [
          //                 Text(
          //                   'Passing Year: ',
          //                   style: TextStyle(
          //                       fontSize: 15.sp, fontWeight: FontWeight.w500),
          //                 ),
          //                 Text(
          //                   '${details['field1']}',
          //                   style: TextStyle(
          //                       fontSize: 15.sp, fontWeight: FontWeight.w400),
          //                 ),
          //               ],
          //             ),
          //             Icon(
          //               Icons.location_on,
          //               color: ColorHelper.primaryColor,
          //             )
          //           ],
          //         ),
          //       ),
          //       SizedBox(
          //         height: 10.h,
          //       ),
          //       Container(
          //         height: 50.h,
          //         padding: EdgeInsets.symmetric(horizontal: 10.w),
          //         decoration: BoxDecoration(
          //             border:
          //                 Border.all(color: Colors.grey.shade300, width: 1.2),
          //             borderRadius: BorderRadius.circular(5.r)),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Row(
          //               children: [
          //                 Text(
          //                   'Total Marks: ',
          //                   style: TextStyle(
          //                       fontSize: 15.sp, fontWeight: FontWeight.w500),
          //                 ),
          //                 Text('${details['field2']}'),
          //               ],
          //             ),
          //             Icon(
          //               Icons.class_,
          //               color: ColorHelper.primaryColor,
          //             )
          //           ],
          //         ),
          //       ),
          //       SizedBox(
          //         height: 10.h,
          //       ),
          //       Container(
          //         height: 50.h,
          //         padding: EdgeInsets.symmetric(horizontal: 10.w),
          //         decoration: BoxDecoration(
          //             border:
          //                 Border.all(color: Colors.grey.shade300, width: 1.2),
          //             borderRadius: BorderRadius.circular(5.r)),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Row(
          //               children: [
          //                 Text(
          //                   'Obtained Marks: ',
          //                   style: TextStyle(
          //                       fontSize: 15.sp, fontWeight: FontWeight.w500),
          //                 ),
          //                 Text(' ${details['field3']}'),
          //               ],
          //             ),
          //             Icon(
          //               Icons.class_,
          //               color: ColorHelper.primaryColor,
          //             )
          //           ],
          //         ),
          //       ),
          //       SizedBox(
          //         height: 10.h,
          //       ),
          //       Container(
          //         height: 50.h,
          //         padding: EdgeInsets.symmetric(horizontal: 10.w),
          //         decoration: BoxDecoration(
          //             border:
          //                 Border.all(color: Colors.grey.shade300, width: 1.2),
          //             borderRadius: BorderRadius.circular(5.r)),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Row(
          //               children: [
          //                 Text(
          //                   'Percentage:',
          //                   style: TextStyle(
          //                       fontSize: 15.sp, fontWeight: FontWeight.w500),
          //                 ),
          //                 Text(' ${details['field4']}'),
          //               ],
          //             ),
          //             Icon(
          //               Icons.class_,
          //               color: ColorHelper.primaryColor,
          //             )
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),

          // SpaceHelper().verticalSpace10,
          // CustomTextField().textField(
          //     controller: teacherLoginController.degreeController.value,
          //     levelText: "Degree",
          //     suffixIcon: Icons.school),
          // SpaceHelper().verticalSpace10,
          // CustomTextField().textField(
          //     controller: teacherLoginController.passingYearController.value,
          //     levelText: "Passing Year",
          //     suffixIcon: Icons.location_on),
          // SpaceHelper().verticalSpace10,
          // CustomTextField().textField(
          //     controller: teacherLoginController.totalMarksController.value,
          //     levelText: "Total Marks",
          //     suffixIcon: Icons.class_),
          // SpaceHelper().verticalSpace10,
          // CustomTextField().textField(
          //     controller: teacherLoginController.obtainedController.value,
          //     levelText: "Obtained Marks",
          //     suffixIcon: Icons.class_),
          // SpaceHelper().verticalSpace10,
          // CustomTextField().textField(
          //     controller: teacherLoginController.percentageController.value,
          //     levelText: "Percentage",
          //     suffixIcon: Icons.class_),
          SpaceHelper().verticalSpace10,
          Text(
            'Teaching Details',
            style: FontStyles().largeTextRed,
          ),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: teacherLoginController.schoolNameController.value,
              levelText: "Teaching School Name",
              suffixIcon: Icons.school),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: teacherLoginController.experienceController.value,
              levelText: "Write About Any Other Experience",
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
                teacherLoginController.adharCardPath.value == ''
                    ? const Text('Aadhar Card')
                    : Image.file(
                        File(teacherLoginController.adharCardPath.value),
                        width: 60.w, // Adjust as needed
                        height: 35.h, // Adjust as needed
                        fit: BoxFit.cover,
                      ),
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: ElevatedButton(
                    onPressed: () {
                      openFileExplorer("adharcard");
                    },
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
                teacherLoginController.photoPath.value == ""
                    ? const Text('Photo')
                    : Image.file(
                        File(teacherLoginController.photoPath.value),
                        width: 60.w, // Adjust as needed
                        height: 35.h, // Adjust as needed
                        fit: BoxFit.cover,
                      ),
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: ElevatedButton(
                    onPressed: () {
                      openFileExplorer("photo");
                    },
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
                teacherLoginController.signaturePath.value == ""
                    ? const Text('Signature')
                    : Image.file(
                        File(teacherLoginController.signaturePath.value),
                        width: 60.w, // Adjust as needed
                        height: 35.h, // Adjust as needed
                        fit: BoxFit.cover,
                      ),
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: ElevatedButton(
                    onPressed: () {
                      openFileExplorer("signature");
                    },
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
                teacherLoginController.schoolPhotoPath.value == ""
                    ? const Text('School')
                    : Image.file(
                        File(teacherLoginController.schoolPhotoPath.value),
                        width: 60.w, // Adjust as needed
                        height: 35.h, // Adjust as needed
                        fit: BoxFit.cover,
                      ),
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: ElevatedButton(
                    onPressed: () {
                      openFileExplorer("school");
                    },
                    child: const Text('Upload File'),
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
                onPressed: () async {
                  if (teacherLoginController.nameController.value.text.isEmpty ||
                      teacherLoginController
                          .sdwoController.value.text.isEmpty ||
                      teacherLoginController
                          .emailController.value.text.isEmpty ||
                      teacherLoginController
                          .mobileController.value.text.isEmpty ||
                      teacherLoginController.dob.value.isEmpty ||
                      teacherLoginController
                          .addressController.value.text.isEmpty ||
                      teacherLoginController
                          .passwordController.value.text.isEmpty ||
                      teacherLoginController
                          .schoolNameController.value.text.isEmpty ||
                      teacherLoginController
                          .experienceController.value.text.isEmpty ||
                      teacherLoginController.adharCardPath.value.isEmpty ||
                      teacherLoginController.photoPath.value.isEmpty ||
                      teacherLoginController.signaturePath.value.isEmpty ||
                      teacherLoginController.schoolPhotoPath.value.isEmpty ||
                      teacherLoginController.nameController.value.text == "" ||
                      teacherLoginController.sdwoController.value.text == "" ||
                      teacherLoginController.emailController.value.text == "" ||
                      teacherLoginController.mobileController.value.text ==
                          "" ||
                      teacherLoginController.dob.value == "" ||
                      teacherLoginController.addressController.value.text ==
                          "" ||
                      teacherLoginController.passwordController.value.text ==
                          "" ||
                      teacherLoginController.schoolNameController.value.text ==
                          "" ||
                      teacherLoginController.experienceController.value.text ==
                          "" ||
                      schoolOrInstututionAddress == "" ||
                      teacherLoginController.adharCardPath.value == "" ||
                      teacherLoginController.photoPath.value == "" ||
                      teacherLoginController.signaturePath.value == "" ||
                      teacherLoginController.schoolPhotoPath.value == "") {
                    Fluttertoast.showToast(
                      msg: 'Please fill in all required fields',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else if (teacherLoginController
                          .mobileController.value.text.length <
                      10) {
                    Fluttertoast.showToast(
                      msg: 'The mobile field must be 10 digits.',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else if (teacherLoginController.isPasswordValid(
                          teacherLoginController
                              .passwordController.value.text) ==
                      false) {
                    Fluttertoast.showToast(
                      msg:
                          "The password field must be at least 10 characters.\nPassword should contain upper case, lower case, numbers and special characters",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else if (teacherLoginController.isEmailValid(
                          teacherLoginController.emailController.value.text) ==
                      false) {
                    Fluttertoast.showToast(
                      msg: 'Insert a valid email.',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else if (teacherLoginController
                          .passwordController.value.text !=
                      teacherLoginController.conpasswordController.value.text) {
                    Fluttertoast.showToast(
                      msg: 'Please make sure your password match .',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else if (teacherLoginController.educationDetails.isEmpty) {
                    Fluttertoast.showToast(
                      msg: 'Add educational details',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else {
                    await teacherLoginController.submitTeacherDetails();
                    Get.off(() => const LoginScreen());
                  }
                },
                child: Obx(
                  () => teacherLoginController.submitting.value
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset("images/img.gif"),
                        )
                      : Text(
                          'Update Profile',
                          style: TextStyle(color: Colors.white, fontSize: 18.h),
                        ),
                )),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 30.h,
          ),

          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }

  Widget _buildEducationDetailsSection(Map<String, String> details) {
    int index = teacherLoginController.educationDetails.indexOf(details);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1.2),
                  borderRadius: BorderRadius.circular(5.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Educatiuon: ',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w500),
                      ),
                      Text('${details['option']}')
                    ],
                  ),
                  const Icon(
                    Icons.school,
                    color: ColorHelper.primaryColor,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1.2),
                  borderRadius: BorderRadius.circular(5.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Passing Year: ',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${details['passingYear']}',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.location_on,
                    color: ColorHelper.primaryColor,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1.2),
                  borderRadius: BorderRadius.circular(5.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Total Marks: ',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w500),
                      ),
                      Text(' ${details['totalMarks']}'),
                    ],
                  ),
                  const Icon(
                    Icons.class_,
                    color: ColorHelper.primaryColor,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1.2),
                  borderRadius: BorderRadius.circular(5.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Obtained Marks: ',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w500),
                      ),
                      Text('${details['obtainedMarks']}'),
                    ],
                  ),
                  const Icon(
                    Icons.class_,
                    color: ColorHelper.primaryColor,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1.2),
                  borderRadius: BorderRadius.circular(5.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Percentage:',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w500),
                      ),
                      Text(' ${details['percentage']}'),
                    ],
                  ),
                  const Icon(
                    Icons.class_,
                    color: ColorHelper.primaryColor,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                _removeEducationDetails(index);
              },
              child: Container(
                width: 80.w,
                height: 30.h,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: ColorHelper.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Remove',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _removeEducationDetails(int index) {
    setState(() {
      teacherLoginController.educationDetails.removeAt(index);
    });
  }
}




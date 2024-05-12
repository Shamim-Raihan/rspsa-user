import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rspsa_user/controller/login_controller.dart';
import 'package:rspsa_user/controller/signup_controller.dart';
import 'package:rspsa_user/custom_widget.dart/cusotm_text_field.dart';
import 'package:rspsa_user/screens/common/login_screen.dart';
import 'package:rspsa_user/screens/student_portal/controller/student_signup_controller.dart';
import 'package:rspsa_user/utils/color_helper.dart';
import 'package:rspsa_user/utils/space_helper.dart';
import 'package:rspsa_user/utils/text_style.dart';

import '../../models/program_list_response.dart';
import '../../models/talent_details_response.dart';
import '../../models/talent_list_response.dart';

class StudentSignupScreen extends StatefulWidget {
  const StudentSignupScreen({super.key});

  @override
  State<StudentSignupScreen> createState() => _StudentSignupScreenState();
}

class _StudentSignupScreenState extends State<StudentSignupScreen> {
  final sDateFormate = "dd/MM/yyyy";
  DateTime _dateTime = DateTime.now();
  bool isDateSelected = false;
  bool agreeToTerms = false;
  File? _file;
  PlatformFile? _platformFile;
  SignupController signupController = Get.find();

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

  String? currentEducationProof;
  String? photo;
  String? signature;
  String? paymentProof;
  String? aadharCard;

  void _openFileExplorer({required int from}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        String? filePath = result.files.single.path;

        if (filePath != null) {
          setState(() {
            if (from == 1) {
              currentEducationProof = filePath;
            }
            if (from == 2) {
              photo = filePath;
            }
            if (from == 3) {
              signature = filePath;
            }
            if (from == 4) {
              paymentProof = filePath;
            }
            if (from == 5) {
              aadharCard = filePath;
            }

            log(filePath.toString());
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
  Datum? _selectedDatum;
  ProgramList? _selectedProgram;
  TalentDetails? _selectedTalentDetails;

  bool showAdditionalDropdowns =
      false; // Determines if additional dropdowns should be shown
  String?
      selectedAppearingClass; // Selected value of the first additional dropdown
  String? _selectedOption2; // Selected value of the second additional dropdown
  bool showTextWidgets = false;
  bool selectedOption2Valid = false;

  // Options for the additional dropdowns (update based on the selected program)
  List<String> optionsForDropdown1 = [];
  List<String> optionsForDropdown2 = ['OptionA', 'OptionB'];
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

  StudentSignupController studentSignupController = Get.find();

  @override
  Widget build(BuildContext context) {
    studentSignupController.nameController.value.text =
        signupController.nameController.value.text;
    studentSignupController.emailController.value.text =
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
                    buildInputAndActionView(studentSignupController, context),
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
      StudentSignupController studentSignupController, BuildContext context) {
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
          // Obx(
          //   () =>
          //    Container(
          //     height: 50.h,
          //     padding: const EdgeInsets.symmetric(horizontal: 10),
          //     decoration: BoxDecoration(
          //         border: Border.all(width: 1, color: Colors.grey.shade300),
          //         borderRadius: BorderRadius.circular(5)),
          //     child: DropdownButton<Datum>(
          //       underline: const SizedBox(),
          //       hint: _selectedDatum == null
          //           ? const Text('Select Program')
          //           : Text(
          //               _selectedDatum!.title!,
          //               style: FontStyles().normalTextBlack,
          //             ),
          //       isExpanded: true,
          //       iconSize: 30.0,
          //       style: const TextStyle(color: Colors.blue),
          //       items: studentSignupController.programCategoryList.map((datum) {
          //         return DropdownMenuItem<Datum>(
          //           value: datum,
          //           child: Text(
          //             datum.title!,
          //             style: FontStyles().normalTextBlack,
          //           ),
          //         );
          //       }).toList(),
          //       onChanged: (selectedDatum) {
          //         setState(() {
          //           _selectedDatum = selectedDatum;
          //         });
          //       },
          //     ),

          //     // DropdownButton(
          //     //   underline: const SizedBox(),
          //     //   hint: _dropDownValue == null
          //     //       ? const Text('Select Program')
          //     //       : Text(
          //     //           _dropDownValue!,
          //     //           style: FontStyles().normalTextBlack,
          //     //         ),
          //     //   isExpanded: true,
          //     //   iconSize: 30.0,
          //     //   style: const TextStyle(color: Colors.blue),
          //     //   items: ['Program 1', 'Program 1', 'Program 1'].map(
          //     //     (val) {
          //     //       return DropdownMenuItem<String>(
          //     //         value: val,
          //     //         child: Text(
          //     //           val,
          //     //           style: FontStyles().normalTextBlack,
          //     //         ),
          //     //       );
          //     //     },
          //     //   ).toList(),
          //     //   onChanged: (val) {
          //     //     setState(
          //     //       () {
          //     //         _dropDownValue = val;
          //     //       },
          //     //     );
          //     //   },
          //     // ),
          //   ),
          // ),

          Obx(
            () => Container(
              height: 50.h,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(5)),
              child: DropdownButton<Datum>(
                underline: const SizedBox(),
                hint: _selectedDatum == null
                    ? const Text('Enrollment Rules/Talent')
                    : Text(
                        _selectedDatum!.title!,
                        style: FontStyles().normalTextBlack,
                      ),
                isExpanded: true,
                iconSize: 30.0,
                style: const TextStyle(color: Colors.blue),
                items: studentSignupController.talentList.map((datum) {
                  return DropdownMenuItem<Datum>(
                    value: datum,
                    child: Text(
                      datum.title!,
                      style: FontStyles().normalTextBlack,
                    ),
                  );
                }).toList(),
                onChanged: (selectedDatum) {
                  setState(() {
                    _selectedDatum = selectedDatum;

                    _selectedProgram = null;
                    _selectedTalentDetails = null;
                    selectedOption2Valid = false;
                    showAdditionalDropdowns = true;

                    studentSignupController.getProgramList(
                        talentId: _selectedDatum!.id.toString());
                    studentSignupController.getTalentDetailsList(
                        talentId: _selectedDatum!.id.toString());
                  });
                },
              ),
            ),
          ),

          if (showAdditionalDropdowns) ...[
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Obx(
                () => Container(
                  height: 50.h,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButton<ProgramList>(
                    underline: const SizedBox(),
                    hint: _selectedProgram == null
                        ? const Text('Select Program')
                        : Text(
                            _selectedProgram!.name!,
                            style: FontStyles().normalTextBlack,
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: const TextStyle(color: Colors.blue),
                    items: studentSignupController.programList.map((program) {
                      return DropdownMenuItem<ProgramList>(
                        value: program,
                        child: Text(
                          program.name!,
                          style: FontStyles().normalTextBlack,
                        ),
                      );
                    }).toList(),
                    onChanged: (selectedProgram) {
                      setState(() {
                        _selectedProgram = selectedProgram;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Container(
                height: 50.h,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton<TalentDetails>(
                  underline: const SizedBox(),
                  hint: _selectedTalentDetails == null
                      ? const Text('Registration for')
                      : Text(
                          _selectedTalentDetails!.registrationFor!,
                          style: FontStyles().normalTextBlack,
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: const TextStyle(color: Colors.blue),
                  items: studentSignupController.talentDetailsList
                      .map((talentDetails) {
                    return DropdownMenuItem<TalentDetails>(
                      value: talentDetails,
                      child: Text(
                        talentDetails.registrationFor!,
                        style: FontStyles().normalTextBlack,
                      ),
                    );
                  }).toList(),
                  onChanged: (selectedTalentDetails) {
                    setState(() {
                      _selectedTalentDetails = selectedTalentDetails;
                      selectedOption2Valid = true;
                    });
                  },
                ),
              ),
            ),
            if (selectedOption2Valid) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    'Enrollment Fee *:',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                  ),
                  Container(
                    height: 50.h,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 5.h),
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _selectedTalentDetails!.enrollmentFee!.toString(),
                        style: FontStyles().normalTextBlack,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    'Fee Refundable *:',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                  ),
                  Container(
                    height: 50.h,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 5.h),
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _selectedTalentDetails!.feeRefundable!.toString(),
                        style: FontStyles().normalTextBlack,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    'Participation Period *:',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                  ),
                  Container(
                    height: 50.h,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 5.h),
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _selectedTalentDetails!.participationPeriod!.toString(),
                        style: FontStyles().normalTextBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],

          SpaceHelper().verticalSpace20,
          Text(
            'Student Profile',
            style: FontStyles().largeTextRed,
          ),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: studentSignupController.nameController.value,
              levelText: "Student Name",
              suffixIcon: Icons.person_2_outlined,
              enabled: false),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: studentSignupController.sdcoController.value,
              levelText: "S/D/C/o",
              suffixIcon: Icons.person_2_outlined),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: studentSignupController.emailController.value,
              levelText: "Email",
              suffixIcon: Icons.mail_outline,
              enabled: false),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: studentSignupController.mobileController.value,
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
              controller: studentSignupController.addressController.value,
              levelText: "Full Address",
              suffixIcon: Icons.location_on),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: studentSignupController.aadharController.value,
              levelText: "Aadhar Number",
              suffixIcon: Icons.numbers),
          // SpaceHelper().verticalSpace10,
          // SizedBox(
          //   height: 50.h,
          //   child: TextFormField(
          //     controller: studentSignupController.passwordController.value,
          //     obscureText: !studentSignupController.visiblePass.value,
          //     decoration: InputDecoration(
          //         focusedBorder: const OutlineInputBorder(
          //             borderSide: BorderSide(
          //                 color: ColorHelper.primaryColor, width: 1.2)),
          //         enabledBorder: OutlineInputBorder(
          //             borderSide:
          //                 BorderSide(color: Colors.grey.shade300, width: 1.2)),
          //         border: const OutlineInputBorder(
          //             borderSide: BorderSide(color: Colors.black, width: 1.2)),
          //         suffixIcon: studentSignupController.visiblePass.value
          //             ? IconButton(
          //                 onPressed: () {
          //                   setState(() {
          //                     studentSignupController.visiblePass.value
          //                         ? studentSignupController.visiblePass.value =
          //                             false
          //                         : studentSignupController.visiblePass.value =
          //                             true;
          //                   });
          //                 },
          //                 icon: const Icon(Icons.visibility,
          //                     color: ColorHelper.primaryColor))
          //             : IconButton(
          //                 onPressed: () {
          //                   setState(() {
          //                     studentSignupController.visiblePass.value
          //                         ? studentSignupController.visiblePass.value =
          //                             false
          //                         : studentSignupController.visiblePass.value =
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
          //     controller:
          //         studentSignupController.confirmPasswordController.value,
          //     obscureText: !studentSignupController.visibleConfirmPass.value,
          //     decoration: InputDecoration(
          //         focusedBorder: const OutlineInputBorder(
          //             borderSide: BorderSide(
          //                 color: ColorHelper.primaryColor, width: 1.2)),
          //         enabledBorder: OutlineInputBorder(
          //             borderSide:
          //                 BorderSide(color: Colors.grey.shade300, width: 1.2)),
          //         border: const OutlineInputBorder(
          //             borderSide: BorderSide(color: Colors.black, width: 1.2)),
          //         suffixIcon: studentSignupController.visibleConfirmPass.value
          //             ? IconButton(
          //                 onPressed: () {
          //                   setState(() {
          //                     studentSignupController.visibleConfirmPass.value
          //                         ? studentSignupController
          //                             .visibleConfirmPass.value = false
          //                         : studentSignupController
          //                             .visibleConfirmPass.value = true;
          //                   });
          //                 },
          //                 icon: const Icon(Icons.visibility,
          //                     color: ColorHelper.primaryColor))
          //             : IconButton(
          //                 onPressed: () {
          //                   setState(() {
          //                     studentSignupController.visibleConfirmPass.value
          //                         ? studentSignupController
          //                             .visibleConfirmPass.value = false
          //                         : studentSignupController
          //                             .visibleConfirmPass.value = true;
          //                   });
          //                 },
          //                 icon: const Icon(
          //                   Icons.visibility_off,
          //                   color: ColorHelper.primaryColor,
          //                 )),
          //         labelText: 'Confirm Password',
          //         labelStyle: const TextStyle(color: Colors.black)),
          //   ),
          // ),

          SpaceHelper().verticalSpace10,
          Text(
            'Education Details',
            style: FontStyles().largeTextRed,
          ),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: studentSignupController.schoolNameController.value,
              levelText: "School/Institute Name",
              suffixIcon: Icons.school),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: studentSignupController.schoolAddressController.value,
              levelText: "School/Institute Address",
              suffixIcon: Icons.location_on),
          SpaceHelper().verticalSpace10,
          // CustomTextField().textField(
          //     controller: studentSignupController.schoolAddressController.value,
          //     levelText: "Appearing Class",
          //     suffixIcon: Icons.class_),
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Container(
              height: 50.h,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(5)),
              child: DropdownButton<String>(
                underline: const SizedBox(),
                hint: const Text('Appearing Class'),
                isExpanded: true,
                value: selectedAppearingClass,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedAppearingClass = newValue;
                  });
                },
                items: studentSignupController.appearingClasss.map((option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(
                      option,
                      style: FontStyles().normalTextBlack,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SpaceHelper().verticalSpace10,
          Text(
            'Bank Details',
            style: FontStyles().largeTextRed,
          ),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: studentSignupController.bankNameController.value,
              levelText: "Bank Name",
              suffixIcon: Icons.balance),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller:
                  studentSignupController.accountHolderNameController.value,
              levelText: "Account Holder Name",
              suffixIcon: Icons.balance),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: studentSignupController.accountNumberController.value,
              levelText: "Account Number",
              suffixIcon: Icons.balance),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: studentSignupController.ifscCodeController.value,
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
                    onPressed: () {
                      _openFileExplorer(from: 1);
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
                const Text('Photo'),
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: ElevatedButton(
                    onPressed: () {
                      _openFileExplorer(from: 2);
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
                const Text('Signature'),
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: ElevatedButton(
                    onPressed: () {
                      _openFileExplorer(from: 3);
                    },
                    child: const Text('Upload File'),
                  ),
                ),
              ],
            ),
          ),
          SpaceHelper().verticalSpace10,
          const Divider(),
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
                    onPressed: () {
                      _openFileExplorer(from: 4);
                    },
                    child: const Text('Upload File'),
                  ),
                ),
              ],
            ),
          ),
          SpaceHelper().verticalSpace10,
          const Center(child: Text('OR')),
          SpaceHelper().verticalSpace10,
          CustomTextField().textField(
              controller: studentSignupController.utrController.value,
              levelText: "UTR Number",
              suffixIcon: Icons.pin_rounded),
          const Divider(),
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
                    onPressed: () {
                      _openFileExplorer(from: 5);
                    },
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
              controller: studentSignupController.declarationController.value,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorHelper.primaryColor, width: 1.2)),
                suffixIcon: const Icon(Icons.description,
                    color: ColorHelper.primaryColor),
                labelText: 'Declaration',
                labelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1.2)),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.2)),
              ),
            ),
          ),
          SpaceHelper().verticalSpace5,
          Container(
            width: 313.w,
            height: 56.h,
            // color: Colors.red,
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 28.w,
                  height: 28.h,
                  padding: EdgeInsets.all(4.sp),
                  child: Checkbox(
                    activeColor: ColorHelper.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.r)),
                    value: agreeToTerms,
                    onChanged: (newValue) {
                      setState(() {
                        agreeToTerms = newValue ?? false;
                      });
                    },
                  ),
                ),
                SizedBox(width: 4.w),
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    // width: 261.w,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'I agree to the ',
                            style: TextStyle(
                              color: const Color(0xFF181E29),
                              fontSize: 14.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'terms and conditions',
                            style: TextStyle(
                              color: const Color(0xFF1D4ED8),
                              fontSize: 14.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
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
              onPressed: () {
                if (_selectedProgram == null) {
                  var sn = const SnackBar(
                    content: Text('Select a program'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return;
                }
                if (_selectedTalentDetails == null) {
                  var sn = const SnackBar(
                    content: Text('Please select "Registration for" option.'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return;
                }

                if (studentSignupController.nameController.value.text.isEmpty) {
                  var sn = const SnackBar(
                    content: Text('Student Name required'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return;
                }

                if (studentSignupController.sdcoController.value.text.isEmpty) {
                  var sn = const SnackBar(
                    content: Text('S/D/C/o required'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return;
                }

                if (studentSignupController
                    .emailController.value.text.isEmpty) {
                  var sn = const SnackBar(
                    content: Text('Email required'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return;
                }

                final mobileNumber =
                    studentSignupController.mobileController.value.text;
                if (mobileNumber.isEmpty || mobileNumber.length != 10) {
                  var sn = const SnackBar(
                    content: Text('Mobile number must be exactly 10 digits.'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return;
                }

                if (!isDateSelected) {
                  var sn = const SnackBar(
                    content: Text('Date of Birth required'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return;
                }

                if (studentSignupController
                    .addressController.value.text.isEmpty) {
                  var sn = const SnackBar(
                    content: Text('Full Address required'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return;
                }

                final aadharNumber =
                    studentSignupController.aadharController.value.text;
                if (aadharNumber.isEmpty || aadharNumber.length != 12) {
                  var sn = const SnackBar(
                    content: Text('Aadhar Number must be exactly 12 digits.'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return; // Exit the function if the Aadhar Number is invalid
                }
                final password =
                    studentSignupController.passwordController.value.text;
                final confirmPassword = studentSignupController
                    .confirmPasswordController.value.text;
                if (password != confirmPassword) {
                  var sn = const SnackBar(
                    content:
                        Text('Password and confirm password do not match.'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return; // Exit the function if the passwords do not match
                }

                if (studentSignupController
                    .schoolNameController.value.text.isEmpty) {
                  var sn = const SnackBar(
                    content: Text('School/Institute Name required'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return;
                }

                if (studentSignupController
                    .schoolAddressController.value.text.isEmpty) {
                  var sn = const SnackBar(
                    content: Text('School/Institute Address required'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return;
                }

                if (selectedAppearingClass == null) {
                  var sn = const SnackBar(
                    content: Text('Appearing Class required'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return;
                }

                if (studentSignupController
                    .bankNameController.value.text.isEmpty) {
                  var sn = const SnackBar(
                    content: Text('Bank Name required'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return;
                }

                if (studentSignupController
                    .accountHolderNameController.value.text.isEmpty) {
                  var sn = const SnackBar(
                    content: Text('Account Holder Name required'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return;
                }

                if (studentSignupController
                    .accountNumberController.value.text.isEmpty) {
                  var sn = const SnackBar(
                    content: Text('Account Number required'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return;
                }

                if (studentSignupController
                    .ifscCodeController.value.text.isEmpty) {
                  var sn = const SnackBar(
                    content: Text('IFSC Code required'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return;
                }
                if (!agreeToTerms) {
                  var sn = const SnackBar(
                    content:
                        Text('You must agree to the terms and conditions.'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                  return; // Exit the function if the user has not agreed to the terms and conditions
                }

                studentSignupController.studentSignup(
                  talentId: _selectedDatum!.id!.toString(),
                  programId: _selectedProgram!.id!.toString(),
                  talentDetailsId: _selectedTalentDetails!.id.toString(),
                  name: studentSignupController.nameController.value.text,
                  fatherName: studentSignupController.sdcoController.value.text,
                  email: studentSignupController.emailController.value.text,
                  mobile: studentSignupController.mobileController.value.text,
                  dob: DateFormat('yyyy-MM-dd').format(_dateTime),
                  password: signupController.passwordController.value.text,
                  address: studentSignupController.addressController.value.text,
                  aadharNumber:
                      studentSignupController.aadharController.value.text,
                  schoolOrInstitutionName:
                      studentSignupController.schoolNameController.value.text,
                  schoolOrInstitutionAddress: studentSignupController
                      .schoolAddressController.value.text,
                  appearingClass: selectedAppearingClass!,
                  bankName:
                      studentSignupController.bankNameController.value.text,
                  accountHolderName: studentSignupController
                      .accountHolderNameController.value.text,
                  accountNumber: studentSignupController
                      .accountNumberController.value.text,
                  ifscCode:
                      studentSignupController.ifscCodeController.value.text,
                  utrNo: studentSignupController.utrController.value.text,
                  declaration:
                      studentSignupController.declarationController.value.text,
                  termsAndConditions: agreeToTerms ? "1" : "0",
                  registrationFor: _selectedTalentDetails!.registrationFor!,
                  currentEducationProof: currentEducationProof,
                  photo: photo,
                  signature: signature,
                  paymentProof: paymentProof,
                  aadharCard: aadharCard,
                );
              },

              // onPressed: () {
              //   studentSignupController.studentSignup(
              //       talentId: _selectedDatum!.id!.toString(),
              //       programId: _selectedProgram!.id!.toString(),
              //       talentDetailsId: _selectedTalentDetails!.id.toString(),
              //       name: studentSignupController.nameController.value.text,
              //       fatherName:
              //           studentSignupController.sdcoController.value.text,
              //       email: studentSignupController.emailController.value.text,
              //       mobile: studentSignupController.mobileController.value.text,
              //       dob: DateFormat('yyyy-MM-dd').format(_dateTime),
              //       password:
              //           studentSignupController.passwordController.value.text,
              //       address:
              //           studentSignupController.addressController.value.text,
              //       aadharNumber:
              //           studentSignupController.aadharController.value.text,
              //       schoolOrInstitutionName:
              //           studentSignupController.schoolNameController.value.text,
              //       schoolOrInstitutionAddress: studentSignupController
              //           .schoolAddressController.value.text,
              //       appearingClass: selectedAppearingClass!,
              //       bankName:
              //           studentSignupController.bankNameController.value.text,
              //       accountHolderName: studentSignupController
              //           .accountHolderNameController.value.text,
              //       accountNumber: studentSignupController
              //           .accountNumberController.value.text,
              //       ifscCode:
              //           studentSignupController.ifscCodeController.value.text,
              //       utrNo: studentSignupController.utrController.value.text,
              //       declaration: studentSignupController
              //           .declarationController.value.text,
              //       termsAndConditions: agreeToTerms ? "1" : "0",
              //       registrationFor: _selectedTalentDetails!.registrationFor!,
              //       currentEducationProof: currentEducationProof!,
              //       photo: photo!,
              //       signature: signature!,
              //       paymentProof: paymentProof!,
              //       aadharCard: aadharCard!);
              // },

              child: Text(
                'Update Profile',
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

          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}

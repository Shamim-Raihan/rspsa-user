import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
  EmployeeController employeeController = Get.put(EmployeeController());
  final sDateFormate = "dd/MM/yyyy";
  DateTime _dateTime = DateTime.now();
  bool isDateSelected = false;
  File? _file;
  PlatformFile? _platformFile;

  String? _selectedOption1;
  String? _selectedOption2;
  String? _selectedOption3;
  bool showDropdown2 = false; // Control visibility of second dropdown
  bool showDropdown3 = false; // Control visibility of third dropdown

  // Options for the dropdowns
  List<String> optionsForDropdown1 = ['Select', 'Dhaka', 'Barishal'];
  List<String> optionsForDropdown2 = ['Select', 'SubOptionA', 'SubOptionB'];
  List<String> optionsForDropdown3 = [
    'Select',
    'SubSubOptionX',
    'SubSubOptionY'
  ];

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

  final List<String> _dropdownOptions = ['Education', 'Option 2', 'Option 3'];
  String _selectedOption = 'Education';

  List<Map<String, String>> _educationDetails = [];
  void _submitEducationDetails() {
    Map<String, String> educationData = {
      'option': _selectedOption,
      'passingYear': employeeController.passingYearController.value.text,
      'totalMarks': employeeController.totalMarksController.value.text,
      'obtainedMarks': employeeController.obtainedController.value.text,
      'percentage': employeeController.percentageController.value.text,
    };
    // print("Captured Education Data: ${educationData}");
    setState(() {
      _educationDetails.add(educationData);
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
                        _selectedOption = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                _buildTextField(employeeController.passingYearController.value,
                    'Passing Year'),
                SizedBox(
                  height: 10.h,
                ),
                _buildTextField(employeeController.totalMarksController.value,
                    'Total Marks'),
                SizedBox(
                  height: 10.h,
                ),
                _buildTextField(employeeController.obtainedController.value,
                    'Obtained Marks'),
                SizedBox(
                  height: 10.h,
                ),
                _buildTextField(employeeController.percentageController.value,
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
              onPressed: _submitEducationDetails,
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
          Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButton<String>(
              underline: const SizedBox(),
              hint: Text('State'),
              isExpanded: true,
              value: _selectedOption1,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption1 = newValue;
                  // Update visibility of second dropdown based on selection
                  showDropdown2 =
                      _selectedOption1 != null && _selectedOption1 != 'Select';
                  // Reset second and third dropdown selections and visibility
                  _selectedOption2 = null;
                  showDropdown3 = false;
                });
              },
              items: optionsForDropdown1.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
          ),

          // Conditionally render the second dropdown
          if (showDropdown2)
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Container(
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton<String>(
                  underline: const SizedBox(),
                  hint: Text('District'),
                  isExpanded: true,
                  value: _selectedOption2,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedOption2 = newValue;
                      // Update visibility of third dropdown based on selection
                      showDropdown3 = _selectedOption2 != null &&
                          _selectedOption2 != 'Select';
                      // Reset third dropdown selection
                      _selectedOption3 = null;
                    });
                  },
                  items: optionsForDropdown2.map((option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                ),
              ),
            ),

          // Conditionally render the third dropdown
          if (showDropdown3)
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Container(
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton<String>(
                  underline: const SizedBox(),
                  hint: Text('Block'),
                  isExpanded: true,
                  value: _selectedOption3,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedOption3 = newValue;
                      // Handle additional logic here if needed for the third dropdown selection
                    });
                  },
                  items: optionsForDropdown3.map((option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Align(
                          alignment: Alignment.centerLeft, child: Text(option)),
                    );
                  }).toList(),
                ),
              ),
            ),
          SpaceHelper().verticalSpace10,
          // CustomTextField().textField(
          //     controller: employeeController.workingAreaController.value,
          //     levelText: "Working Area",
          //     suffixIcon: Icons.location_on),
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
            children: _educationDetails.map((details) {
              return _buildEducationDetailsSection(details);
            }).toList(),
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

  Widget _buildEducationDetailsSection(Map<String, String> details) {
    int index = _educationDetails.indexOf(details);

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
      _educationDetails.removeAt(index);
    });
  }
}

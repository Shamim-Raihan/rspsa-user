import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:rspsa_user/controller/signup_controller.dart';
import 'package:rspsa_user/screens/employee_portal/models/block_model.dart';
import 'package:rspsa_user/screens/employee_portal/models/designation_model.dart';
import 'package:rspsa_user/screens/employee_portal/models/district_model.dart';
import 'package:rspsa_user/screens/employee_portal/models/panchayet_model.dart';
import 'package:rspsa_user/screens/employee_portal/models/state_model.dart';
import 'package:rspsa_user/screens/employee_portal/repository/employe_repository.dart';
import 'package:rspsa_user/utils/constants.dart';

class EmployeeController extends GetxController {
  var emailController = TextEditingController().obs;
  var mobileController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var conpasswordController = TextEditingController().obs;
  var designationController = TextEditingController().obs;
  var workingAreaController = TextEditingController().obs;

  var addressController = TextEditingController().obs;
  var aadharController = TextEditingController().obs;

  var schoolNameController = TextEditingController().obs;
  var schoolAddressController = TextEditingController().obs;
  var appearingClassController = TextEditingController().obs;
  var accountNumberController = TextEditingController().obs;
  var ifscCodeController = TextEditingController().obs;
  var bankNameController = TextEditingController().obs;
  var referelController = TextEditingController().obs;
  var accountNameController = TextEditingController().obs;
  var utrNumberController = TextEditingController().obs;
  var declarationController = TextEditingController().obs;
  var agree = false.obs;

  var registrationForController = TextEditingController().obs;
  var nameController = TextEditingController().obs;
  var father_nameController = TextEditingController().obs;
  var sdcoController = TextEditingController().obs;
  var visiblepass = false.obs;
  var convisiblepass = false.obs;
  var selectedOption = 0.obs;
  var selectedValue = "Select".obs;
  var dob = "Select".obs;
  var aadharcardPath = "".obs;
  var photoPath = "".obs;
  var signaturePath = "".obs;
  var resumePath = "".obs;

  var passingYearController = TextEditingController().obs;
  var totalMarksController = TextEditingController().obs;
  var obtainedController = TextEditingController().obs;
  var percentageController = TextEditingController().obs;

  var designationList=[].obs;
  var stateList=[].obs;
  var districtList=[].obs;
  var blockList=[].obs;
  var panchayetList=[].obs;

  var creatingAccount=false.obs;

  Designation? selectedDesignation;
  StateDetail? selectedState;
  District? selectedDistrict;
  Block? selectedBlock;
  Panchayet? selectedPanchayet;

  List<String> optionsForState = ['Select', 'Dhaka', 'Barishal'];
  List<String> optionsForDistrict = ['Select', 'SubOptionA', 'SubOptionB'];
  List<String> optionsForBlock = [
    'Select',
    'SubSubOptionX',
    'SubSubOptionY'
  ];
  List<String> optionsForPanchayet = [
    'Select',
    'SubSubOptionX',
    'SubSubOptionY'
  ];

  List<Map<String, String>> educationDetails = [];

  String? state;
  String? district;
  String? block;
  String? panchayet;
  @override
  void onInit() {
    getDesignationList();
    getStateList();
    super.onInit();
  }

  Future<void> createEmploye() async{
    creatingAccount.value=true;
    SignupController signupController = Get.find();
    await EmployeRepository().submitEmployeDetails(
        name: nameController.value.text,
        father_name: father_nameController.value.text,
        email: emailController.value.text,
        mobile: mobileController.value.text,
        dob: dob.value,
        aadhar_number: aadharController.value.text,
        address: address,
        password: signupController.passwordController.value.text,
        password_confirmation: signupController.passwordController.value.text,
        degree: educationDetails.map((map) => map['option']!).join(', '),
        passingYear: educationDetails.map((map) => map['passingYear']!).join(', '),
        totalMarks: educationDetails.map((map) => map['totalMarks']!).join(', '),
        obtainedMarks:  educationDetails.map((map) => map['obtainedMarks']!).join(', '),
        percentage:  educationDetails.map((map) => map['percentage']!).join(', '),
        bank_name: bankNameController.value.text,
        account_holder_name: accountNameController.value.text,
        account_number: accountNumberController.value.text,
        ifsc_code: ifscCodeController.value.text,
        designation_id: selectedDesignation!.id.toString(),
        state_id: selectedState!.id.toString(),
        district_id: selectedDistrict!.id.toString(),
        block_id: selectedBlock!.id.toString(),
        panchayat_id: selectedPanchayet!.id.toString(),
        ref_code: referelController.value.text??'',
        photo: photoPath.value,
        signature: signaturePath.value,
        aadhar_cardphoto:aadharcardPath.value,
        resume: resumePath.value);
    creatingAccount.value=false;
  }



Future<void> getDesignationList() async{
  DesignationModel designationModel= await EmployeRepository().getDesignations();
  designationList.value=designationModel.designationList;
  print("sajsdhnfkjsd: ${designationList.length}");
}

  Future<void> getStateList() async{
    StateModel stateModel= await EmployeRepository().getStates();
    stateList.value=stateModel.stateList;
    print("sakjfkjsdhnfkjsd: ${stateList.length}");
  }

  Future<void> getDistrictList() async{
    DistrictModel districtModel= await EmployeRepository().getDistricts(StateId: selectedState!.id!.toString());
    districtList.value=districtModel.districtList;
    print("sakjfkjsnfkjsd: ${districtList.length}");
  }

  Future<void> getBlockList() async{
    BlockModel blockModel= await EmployeRepository().getBlocks(districtId: selectedDistrict!.id!.toString());
    blockList.value=blockModel.blockList;
    print("sakjfkjsnfjsd: ${blockList.length}");
  }

  Future<void> getPanchayetList() async{
    PanchayetModel panchayetModel= await EmployeRepository().getPanchayets(blockId: selectedBlock!.id!.toString());
    panchayetList.value=panchayetModel.panchayetList;
    print("sakjfkjfjsd: ${panchayetList.length}");
  }

  bool isPasswordValid(String password) {
    // Check if the password has at least 10 characters
    if (password.length < 10) {
      return false;
    }

    // Check if the password contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false;
    }

    // Check if the password contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return false;
    }

    // Check if the password contains at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      return false;
    }

    // Check if the password contains at least one special character
    if (!password.contains(RegExp(r'[!@£\$%^&]'))) {
      return false;
    }

    // If all conditions are met, return true
    return true;
  }
  bool isEmailValid(String email) {
    // Regular expression pattern for validating email addresses
    // This pattern checks for basic email format but doesn't guarantee the email exists or is valid
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );

    // Check if the email matches the regular expression pattern
    return emailRegex.hasMatch(email);
  }
}

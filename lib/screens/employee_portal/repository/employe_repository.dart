import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:rspsa_user/screens/employee_portal/models/block_model.dart';
import 'package:rspsa_user/screens/employee_portal/models/designation_model.dart';
import 'package:rspsa_user/screens/employee_portal/models/district_model.dart';
import 'package:rspsa_user/screens/employee_portal/models/panchayet_model.dart';
import 'package:rspsa_user/screens/employee_portal/models/state_model.dart';

import '../../../utils/app_config.dart';
class EmployeRepository{
  Future<void> submitEmployeDetails({
    required String name,
    required String father_name,
    required String email,
    required String mobile,
    required String dob,
    required String aadhar_number,
    required String address,
    required String password,
    required String password_confirmation,
    required String degree,
    required String passingYear,
    required String totalMarks,
    required String obtainedMarks,
    required String percentage,
    required String bank_name,
    required String account_holder_name,
    required String account_number,
    required String ifsc_code,
    required String designation_id,
    required String state_id,
    required String district_id,
    required String block_id,
    required String panchayat_id,
    required String ref_code,
    required String photo,
    required String signature,
    required String aadhar_cardphoto,
    required String resume,
  }) async {
    var headers = {
      'Accept': 'application/json'
    };

    var request = http.MultipartRequest('POST', Uri.parse('https://rspsa.in/api/employee/storee'));
    request.fields.addAll({
      'name': name,
      'father_name': father_name,
      'email': email.trim(),
      'mobile': mobile,
      'dob': dob,
      'address': address,
      'aadhar_number': aadhar_number,
      'password': password.trim(),
      'password_confirmation': password.trim(),
      'degree[]': degree,
      'passing_year[]': passingYear,
      'total_marks[]': totalMarks,
      'obtained_marks[]': obtainedMarks,
      'percentage[]': percentage,
      'bank_name': bank_name,
      'account_holder_name': account_holder_name,
      'account_number': account_number,
      'ifsc_code':ifsc_code,
      'designation_id':designation_id,
      'state_id':state_id,
      'district_id':district_id,
      'block_id':block_id,
      'panchayat_id':panchayat_id,
      'ref_code':ref_code,
    });

    try {
      request.files.add(await http.MultipartFile.fromPath('aadhar_card', aadhar_cardphoto));
      request.files.add(await http.MultipartFile.fromPath('photo', photo));
      request.files.add(await http.MultipartFile.fromPath('signature', signature));
      request.files.add(await http.MultipartFile.fromPath('resume', resume));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {

        Fluttertoast.showToast(
          msg: 'Thanks for registering with us. Please wait for the approval.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        //print(await response.stream.bytesToString());
      } else {
        print("response"+response.reasonPhrase!);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print('Error: $e');
    }
  }


  Future<DesignationModel> getDesignations() async {
    var headers = {
      'Accept': 'application/json'
    };
    Uri uri =
    Uri.parse('${AppConfig.baseUrl}/api/designations');
    final response = await http.get(uri, headers: headers);
    return designationModelFromJson(response.body);
  }

  Future<StateModel> getStates() async {
    var headers = {
      'Accept': 'application/json'
    };
    Uri uri =
    Uri.parse('${AppConfig.baseUrl}/api/states');
    final response = await http.get(uri, headers: headers);
    return stateModelFromJson(response.body);
  }

  Future<DistrictModel> getDistricts({required String StateId}) async {
    var headers = {
      'Accept': 'application/json'
    };
    Uri uri =
    Uri.parse('${AppConfig.baseUrl}/api/districts/$StateId');
    final response = await http.get(uri, headers: headers);
    return districtModelFromJson(response.body);
  }

  Future<BlockModel> getBlocks({required String districtId}) async {
    var headers = {
      'Accept': 'application/json'
    };
    Uri uri =
    Uri.parse('${AppConfig.baseUrl}/api/blocks/$districtId');
    final response = await http.get(uri, headers: headers);
    return blockModelFromJson(response.body);
  }

  Future<PanchayetModel> getPanchayets({required String blockId}) async {
    var headers = {
      'Accept': 'application/json'
    };
    Uri uri =
    Uri.parse('${AppConfig.baseUrl}/api/panchayats/$blockId');
    final response = await http.get(uri, headers: headers);
    return panchayetModelFromJson(response.body);
  }
}
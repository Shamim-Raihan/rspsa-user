import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class TeacherRepository{


  Future<void> submitTeacherDetails({
    required String name,
    required String s_d_w_o,
    required String email,
    required String mobile,
    required String dob,
    required String address,
    required String password,
    required String degree,
    required String passingYear,
    required String totalMarks,
    required String obtainedMarks,
    required String percentage,
    required String teachingSchoolName,
    required String experience,
    required String teachingSchoolAddress,
    required String adharCardPath,
    required String photoPath,
    required String signaturePath,
    required String schoolPhotoPath,
  }) async {
    var headers = {
      'Accept': 'application/json'
    };

    var request = http.MultipartRequest('POST', Uri.parse('https://rspsa.in/api/teacher/store'));
    request.fields.addAll({
      'name': name,
      's_d_w_o': s_d_w_o,
      'email': email.trim(),
      'mobile': mobile,
      'dob': dob,
      'address': address,
      'password': password.trim(),
      'degree[]': degree,
      'passing_year[]': passingYear,
      'total_marks[]': totalMarks,
      'obtained_marks[]': obtainedMarks,
      'percentage[]': percentage,
      'teaching_school_name': teachingSchoolName,
      'experience': experience,
      'teaching_school_address': teachingSchoolAddress,
    });

    try {
      request.files.add(await http.MultipartFile.fromPath('aadhar_card', adharCardPath));
      request.files.add(await http.MultipartFile.fromPath('photo', photoPath));
      request.files.add(await http.MultipartFile.fromPath('signature', signaturePath));
      request.files.add(await http.MultipartFile.fromPath('school_photo', schoolPhotoPath));

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
}
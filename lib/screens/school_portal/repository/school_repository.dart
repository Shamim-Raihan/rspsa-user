import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class SchoolRepository {


  Future<void> submitSchoolDetails({
    required String schoolName,
    required String schoolRegistrationNumber,
    required String email,
    required String mobile,
    required String password,
    required String schoolAddress,
    required String schoolDirectorName,
    required String directorContactNumber,
    required String totalStudent,
    required String totalTeacher,
  }) async {
    var headers = {
      'Accept': 'application/json'
    };

    var request = http.MultipartRequest('POST', Uri.parse('https://rspsa.in/api/school/store'));
    request.fields.addAll({
      'school_name': schoolName,
      'school_registration_number': schoolRegistrationNumber,
      'email': email,
      'mobile': mobile,
      'password': password,
      'school_address': schoolAddress,
      'school_director_name': schoolDirectorName,
      'director_contact_number': directorContactNumber,
      'total_student': totalStudent,
      'total_teacher': totalTeacher,
    });

    try {
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
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
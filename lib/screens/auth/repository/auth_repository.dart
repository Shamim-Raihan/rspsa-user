import 'dart:convert';
import 'dart:developer';

import 'package:rspsa_user/models/login_response.dart';
import 'package:rspsa_user/models/signIn_response.dart';
import 'package:rspsa_user/models/signup_response.dart';
import 'package:http/http.dart' as http;
import '../../../utils/app_config.dart';

class AuthRepository {
  Future<SignupResponse?> signup(
      {required Map<String, dynamic> payload}) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      Uri url = Uri.parse('${AppConfig.baseUrl}/api/register');
      final response =
          await http.post(url, headers: headers, body: jsonEncode(payload));
      if (response.statusCode == 200) {
        return signupResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      log('Error while signing up: $e');
      return null;
    }
  }

  //---------------------login////////////////

  Future<LoginResponse?> login(
      {required String email, required String password}) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };

      var postBody = jsonEncode({
        "email": email,
        "password": password,
      });

      Uri uri = Uri.parse('${AppConfig.baseUrl}/login');
      final response = await http.post(uri, headers: headers, body: postBody);

      if (response.statusCode == true) {
        return loginResponseFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      log('Error while logging in: $e');
      return null;
    }
  }
//-----------------------otpValidation/////

  Future<void> validateOtp(String email, String otp) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var requestBody = json.encode({
      "email": email,
      "otp": otp,
    });

    Uri uri = Uri.parse('${AppConfig.baseUrl}/api/validate-otp');
    final response = await http.post(
      uri,
      headers: headers,
      body: requestBody,
    );

    if (response.statusCode == 200) {
    } else {
      print('Failed to validate OTP: ${response.reasonPhrase}');
    }
  }

  Future<SignInResponse?> registerUser({
    required String type,
    required String name,
    required String email,
    required String mobile,
    required String password,
  }) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      var requestBody = json.encode({
        "type": type,
        "name": name,
        "email": email,
        "mobile": mobile,
        "password": password,
        "password_confirmation": password,
      });

      Uri uri = Uri.parse('${AppConfig.baseUrl}/register');

      final response = await http.post(
        uri,
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        return signInResponseFromJson(response.body);
      } else {
        log('Failed to register: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      log('Error while registering: $e');
      return null;
    }
  }
}

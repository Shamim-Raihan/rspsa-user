import 'dart:convert';
import 'dart:developer';

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
}

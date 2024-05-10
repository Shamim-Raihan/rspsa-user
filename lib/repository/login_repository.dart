import 'dart:convert';
import 'package:rspsa_user/models/logout_response.dart';
import 'package:rspsa_user/utils/app_config.dart';
import 'package:http/http.dart' as http;
import '../models/login_response.dart';

class LoginRepository {


  Future<LoginResponse> login(
      {required String email, required String password}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var postBody = jsonEncode({"email": email, "password": password});

    Uri uri = Uri.parse('${AppConfig.baseUrl}/api/login');
    final response = await http.post(uri, headers: headers, body: postBody);
    return loginResponseFromJson(response.body);
  }

  Future<LogoutResponse> logout({required String accessToken}) async {
    var headers = {'Authorization': 'Bearer $accessToken'};

    Uri uri = Uri.parse('${AppConfig.baseUrl}/api/logout');
    final response = await http.get(uri, headers: headers);
    return logoutResponseFromJson(response.body);
  }
}

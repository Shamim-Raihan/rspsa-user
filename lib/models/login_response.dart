// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool status;
  String msg;
  Data data;

  LoginResponse({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  bool showOtpPage;

  Data({
    required this.showOtpPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        showOtpPage: json["show_otp_page"],
      );

  Map<String, dynamic> toJson() => {
        "show_otp_page": showOtpPage,
      };
}

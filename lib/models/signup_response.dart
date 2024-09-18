import 'dart:convert';

SignupResponse signupResponseFromJson(String str) => SignupResponse.fromJson(json.decode(str));

String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());

class SignupResponse {
    int? status;
    String? msg;

    SignupResponse({
        this.status,
        this.msg,
    });

    factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
        status: json["status"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
    };
}

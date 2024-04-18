// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    bool? status;
    String? msg;
    Data? data;

    LoginResponse({
        this.status,
        this.msg,
        this.data,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class Data {
    User? user;
    String? accessToken;
    String? tokenType;
    String? filePath;

    Data({
        this.user,
        this.accessToken,
        this.tokenType,
        this.filePath,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        filePath: json["file_path"],
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "access_token": accessToken,
        "token_type": tokenType,
        "file_path": filePath,
    };
}

class User {
    int? id;
    String? name;
    String? uniqueCode;
    String? email;
    dynamic emailVerifiedAt;
    dynamic mobile;
    String? address;
    String? image;
    String? status;
    String? role;
    String? isPasswordUpdated;
    dynamic refCode;
    String? totalPayout;
    String? paidAmount;
    String? dueAmount;
    dynamic bankName;
    dynamic accountHolderName;
    dynamic accountNumber;
    dynamic ifscCode;
    dynamic qrCode;
    dynamic referredBy;
    dynamic createdBy;
    DateTime? createdAt;
    DateTime? updatedAt;
    Details? details;

    User({
        this.id,
        this.name,
        this.uniqueCode,
        this.email,
        this.emailVerifiedAt,
        this.mobile,
        this.address,
        this.image,
        this.status,
        this.role,
        this.isPasswordUpdated,
        this.refCode,
        this.totalPayout,
        this.paidAmount,
        this.dueAmount,
        this.bankName,
        this.accountHolderName,
        this.accountNumber,
        this.ifscCode,
        this.qrCode,
        this.referredBy,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.details,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        uniqueCode: json["unique_code"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        mobile: json["mobile"],
        address: json["address"],
        image: json["image"],
        status: json["status"],
        role: json["role"],
        isPasswordUpdated: json["is_password_updated"],
        refCode: json["ref_code"],
        totalPayout: json["total_payout"],
        paidAmount: json["paid_amount"],
        dueAmount: json["due_amount"],
        bankName: json["bank_name"],
        accountHolderName: json["account_holder_name"],
        accountNumber: json["account_number"],
        ifscCode: json["ifsc_code"],
        qrCode: json["qr_code"],
        referredBy: json["referred_by"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        details: json["details"] == null ? null : Details.fromJson(json["details"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "unique_code": uniqueCode,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "mobile": mobile,
        "address": address,
        "image": image,
        "status": status,
        "role": role,
        "is_password_updated": isPasswordUpdated,
        "ref_code": refCode,
        "total_payout": totalPayout,
        "paid_amount": paidAmount,
        "due_amount": dueAmount,
        "bank_name": bankName,
        "account_holder_name": accountHolderName,
        "account_number": accountNumber,
        "ifsc_code": ifscCode,
        "qr_code": qrCode,
        "referred_by": referredBy,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "details": details?.toJson(),
    };
}

class Details {
    int? id;
    String? talentId;
    String? programId;
    String? talentDetailId;
    String? registrationFor;
    String? enrollmentFee;
    String? feeRefundable;
    String? participationPeriod;
    String? name;
    String? fatherName;
    String? mobile;
    String? email;
    DateTime? dob;
    String? address;
    String? aadharNumber;
    String? schoolOrInstituteName;
    String? schoolOrInstituteAddress;
    String? appearingClass;
    String? bankName;
    String? accountHolderName;
    String? accountNumber;
    String? ifscCode;
    String? currentEducationProof;
    String? photo;
    String? signature;
    String? paymentProof;
    dynamic utrNo;
    String? aadharCard;
    String? termsAndConditions;
    String? declaration;
    String? status;
    String? userId;
    String? createdBy;
    DateTime? createdAt;
    DateTime? updatedAt;

    Details({
        this.id,
        this.talentId,
        this.programId,
        this.talentDetailId,
        this.registrationFor,
        this.enrollmentFee,
        this.feeRefundable,
        this.participationPeriod,
        this.name,
        this.fatherName,
        this.mobile,
        this.email,
        this.dob,
        this.address,
        this.aadharNumber,
        this.schoolOrInstituteName,
        this.schoolOrInstituteAddress,
        this.appearingClass,
        this.bankName,
        this.accountHolderName,
        this.accountNumber,
        this.ifscCode,
        this.currentEducationProof,
        this.photo,
        this.signature,
        this.paymentProof,
        this.utrNo,
        this.aadharCard,
        this.termsAndConditions,
        this.declaration,
        this.status,
        this.userId,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
    });

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        talentId: json["talent_id"],
        programId: json["program_id"],
        talentDetailId: json["talent_detail_id"],
        registrationFor: json["registration_for"],
        enrollmentFee: json["enrollment_fee"],
        feeRefundable: json["fee_refundable"],
        participationPeriod: json["participation_period"],
        name: json["name"],
        fatherName: json["father_name"],
        mobile: json["mobile"],
        email: json["email"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        address: json["address"],
        aadharNumber: json["aadhar_number"],
        schoolOrInstituteName: json["school_or_institute_name"],
        schoolOrInstituteAddress: json["school_or_institute_address"],
        appearingClass: json["appearing_class"],
        bankName: json["bank_name"],
        accountHolderName: json["account_holder_name"],
        accountNumber: json["account_number"],
        ifscCode: json["ifsc_code"],
        currentEducationProof: json["current_education_proof"],
        photo: json["photo"],
        signature: json["signature"],
        paymentProof: json["payment_proof"],
        utrNo: json["utr_no"],
        aadharCard: json["aadhar_card"],
        termsAndConditions: json["terms_and_conditions"],
        declaration: json["declaration"],
        status: json["status"],
        userId: json["user_id"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "talent_id": talentId,
        "program_id": programId,
        "talent_detail_id": talentDetailId,
        "registration_for": registrationFor,
        "enrollment_fee": enrollmentFee,
        "fee_refundable": feeRefundable,
        "participation_period": participationPeriod,
        "name": name,
        "father_name": fatherName,
        "mobile": mobile,
        "email": email,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "address": address,
        "aadhar_number": aadharNumber,
        "school_or_institute_name": schoolOrInstituteName,
        "school_or_institute_address": schoolOrInstituteAddress,
        "appearing_class": appearingClass,
        "bank_name": bankName,
        "account_holder_name": accountHolderName,
        "account_number": accountNumber,
        "ifsc_code": ifscCode,
        "current_education_proof": currentEducationProof,
        "photo": photo,
        "signature": signature,
        "payment_proof": paymentProof,
        "utr_no": utrNo,
        "aadhar_card": aadharCard,
        "terms_and_conditions": termsAndConditions,
        "declaration": declaration,
        "status": status,
        "user_id": userId,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

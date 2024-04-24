// To parse this JSON data, do
//
//     final studentSignupResponse = studentSignupResponseFromJson(jsonString);

import 'dart:convert';

StudentSignupResponse studentSignupResponseFromJson(String str) => StudentSignupResponse.fromJson(json.decode(str));

String studentSignupResponseToJson(StudentSignupResponse data) => json.encode(data.toJson());

class StudentSignupResponse {
    bool? status;
    String? msg;
    Data? data;

    StudentSignupResponse({
        this.status,
        this.msg,
        this.data,
    });

    factory StudentSignupResponse.fromJson(Map<String, dynamic> json) => StudentSignupResponse(
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
    String? talentId;
    String? programId;
    String? talentDetailId;
    String? name;
    String? fatherName;
    String? email;
    String? mobile;
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
    dynamic utrNo;
    String? declaration;
    String? termsAndConditions;
    String? registrationFor;
    String? enrollmentFee;
    String? feeRefundable;
    String? participationPeriod;
    dynamic photo;
    dynamic signature;
    dynamic aadharCard;
    dynamic currentEducationProof;
    dynamic paymentProof;
    int? userId;
    int? createdBy;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    Data({
        this.talentId,
        this.programId,
        this.talentDetailId,
        this.name,
        this.fatherName,
        this.email,
        this.mobile,
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
        this.utrNo,
        this.declaration,
        this.termsAndConditions,
        this.registrationFor,
        this.enrollmentFee,
        this.feeRefundable,
        this.participationPeriod,
        this.photo,
        this.signature,
        this.aadharCard,
        this.currentEducationProof,
        this.paymentProof,
        this.userId,
        this.createdBy,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        talentId: json["talent_id"],
        programId: json["program_id"],
        talentDetailId: json["talent_detail_id"],
        name: json["name"],
        fatherName: json["father_name"],
        email: json["email"],
        mobile: json["mobile"],
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
        utrNo: json["utr_no"],
        declaration: json["declaration"],
        termsAndConditions: json["terms_and_conditions"],
        registrationFor: json["registration_for"],
        enrollmentFee: json["enrollment_fee"],
        feeRefundable: json["fee_refundable"],
        participationPeriod: json["participation_period"],
        photo: json["photo"],
        signature: json["signature"],
        aadharCard: json["aadhar_card"],
        currentEducationProof: json["current_education_proof"],
        paymentProof: json["payment_proof"],
        userId: json["user_id"],
        createdBy: json["created_by"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "talent_id": talentId,
        "program_id": programId,
        "talent_detail_id": talentDetailId,
        "name": name,
        "father_name": fatherName,
        "email": email,
        "mobile": mobile,
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
        "utr_no": utrNo,
        "declaration": declaration,
        "terms_and_conditions": termsAndConditions,
        "registration_for": registrationFor,
        "enrollment_fee": enrollmentFee,
        "fee_refundable": feeRefundable,
        "participation_period": participationPeriod,
        "photo": photo,
        "signature": signature,
        "aadhar_card": aadharCard,
        "current_education_proof": currentEducationProof,
        "payment_proof": paymentProof,
        "user_id": userId,
        "created_by": createdBy,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}

import 'dart:convert';

TalentDetailsResponse talentDetailsResponseFromJson(String str) => TalentDetailsResponse.fromJson(json.decode(str));

String talentDetailsResponseToJson(TalentDetailsResponse data) => json.encode(data.toJson());

class TalentDetailsResponse {
    List<TalentDetails>? data;

    TalentDetailsResponse({
        this.data,
    });

    factory TalentDetailsResponse.fromJson(Map<String, dynamic> json) => TalentDetailsResponse(
        data: json["data"] == null ? [] : List<TalentDetails>.from(json["data"]!.map((x) => TalentDetails.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class TalentDetails {
    int? id;
    String? registrationFor;
    String? enrollmentFee;
    String? feeRefundable;
    String? participationPeriod;
    String? talentId;
    String? createdBy;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    TalentDetails({
        this.id,
        this.registrationFor,
        this.enrollmentFee,
        this.feeRefundable,
        this.participationPeriod,
        this.talentId,
        this.createdBy,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory TalentDetails.fromJson(Map<String, dynamic> json) => TalentDetails(
        id: json["id"],
        registrationFor: json["registration_for"],
        enrollmentFee: json["enrollment_fee"],
        feeRefundable: json["fee_refundable"],
        participationPeriod: json["participation_period"],
        talentId: json["talent_id"],
        createdBy: json["created_by"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "registration_for": registrationFor,
        "enrollment_fee": enrollmentFee,
        "fee_refundable": feeRefundable,
        "participation_period": participationPeriod,
        "talent_id": talentId,
        "created_by": createdBy,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

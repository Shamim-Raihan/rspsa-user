// To parse this JSON data, do
//
//     final talentResponse = talentResponseFromJson(jsonString);

import 'dart:convert';

TalentResponse talentResponseFromJson(String str) => TalentResponse.fromJson(json.decode(str));

String talentResponseToJson(TalentResponse data) => json.encode(data.toJson());

class TalentResponse {
    List<Datum>? data;
    String? imagePath;

    TalentResponse({
        this.data,
        this.imagePath,
    });

    factory TalentResponse.fromJson(Map<String, dynamic> json) => TalentResponse(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        imagePath: json["image_path"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "image_path": imagePath,
    };
}

class Datum {
    int? id;
    String? title;
    String? commission;
    String? createdBy;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.title,
        this.commission,
        this.createdBy,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        commission: json["commission"],
        createdBy: json["created_by"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "commission": commission,
        "created_by": createdBy,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

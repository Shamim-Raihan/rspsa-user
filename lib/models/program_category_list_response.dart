// To parse this JSON data, do
//
//     final programCategoryListResponse = programCategoryListResponseFromJson(jsonString);

import 'dart:convert';

ProgramCategoryListResponse programCategoryListResponseFromJson(String str) =>
    ProgramCategoryListResponse.fromJson(json.decode(str));

String programCategoryListResponseToJson(ProgramCategoryListResponse data) =>
    json.encode(data.toJson());

class ProgramCategoryListResponse {
  List<Datum>? data;
  String? imagePath;

  ProgramCategoryListResponse({
    this.data,
    this.imagePath,
  });

  factory ProgramCategoryListResponse.fromJson(Map<String, dynamic> json) =>
      ProgramCategoryListResponse(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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

// To parse this JSON data, do
//
//     final designationModel = designationModelFromJson(jsonString);

import 'dart:convert';

DesignationModel designationModelFromJson(String str) => DesignationModel.fromJson(json.decode(str));

String designationModelToJson(DesignationModel data) => json.encode(data.toJson());

class DesignationModel {
  bool status;
  List<Designation> designationList;

  DesignationModel({
    required this.status,
    required this.designationList,
  });

  factory DesignationModel.fromJson(Map<String, dynamic> json) => DesignationModel(
    status: json["status"],
    designationList: List<Designation>.from(json["data"].map((x) => Designation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(designationList.map((x) => x.toJson())),
  };
}

class Designation {
  int id;
  String designation;
  String status;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;

  Designation({
    required this.id,
    required this.designation,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
    id: json["id"],
    designation: json["designation"],
    status: json["status"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "designation": designation,
    "status": status,
    "created_by": createdBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

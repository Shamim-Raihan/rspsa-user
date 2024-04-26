// To parse this JSON data, do
//
//     final panchayetModel = panchayetModelFromJson(jsonString);

import 'dart:convert';

PanchayetModel panchayetModelFromJson(String str) => PanchayetModel.fromJson(json.decode(str));

String panchayetModelToJson(PanchayetModel data) => json.encode(data.toJson());

class PanchayetModel {
  bool status;
  List<Panchayet> panchayetList;

  PanchayetModel({
    required this.status,
    required this.panchayetList,
  });

  factory PanchayetModel.fromJson(Map<String, dynamic> json) => PanchayetModel(
    status: json["status"],
    panchayetList: List<Panchayet>.from(json["data"].map((x) => Panchayet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(panchayetList.map((x) => x.toJson())),
  };
}

class Panchayet {
  int id;
  String panchayat;
  String status;
  String countryId;
  String stateId;
  String districtId;
  String blockId;
  DateTime createdAt;
  DateTime updatedAt;

  Panchayet({
    required this.id,
    required this.panchayat,
    required this.status,
    required this.countryId,
    required this.stateId,
    required this.districtId,
    required this.blockId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Panchayet.fromJson(Map<String, dynamic> json) => Panchayet(
    id: json["id"],
    panchayat: json["panchayat"],
    status: json["status"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    districtId: json["district_id"],
    blockId: json["block_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "panchayat": panchayat,
    "status": status,
    "country_id": countryId,
    "state_id": stateId,
    "district_id": districtId,
    "block_id": blockId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

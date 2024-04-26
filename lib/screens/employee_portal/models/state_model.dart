// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

StateModel stateModelFromJson(String str) => StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  bool status;
  List<StateDetail> stateList;

  StateModel({
    required this.status,
    required this.stateList,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    status: json["status"],
    stateList: List<StateDetail>.from(json["data"].map((x) => StateDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(stateList.map((x) => x.toJson())),
  };
}

class StateDetail {
  int id;
  String state;
  String stateCode;
  String countryId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  StateDetail({
    required this.id,
    required this.state,
    required this.stateCode,
    required this.countryId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StateDetail.fromJson(Map<String, dynamic> json) => StateDetail(
    id: json["id"],
    state: json["state"],
    stateCode: json["state_code"],
    countryId: json["country_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "state": state,
    "state_code": stateCode,
    "country_id": countryId,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

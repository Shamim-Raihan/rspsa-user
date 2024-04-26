// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsonString);

import 'dart:convert';

DistrictModel districtModelFromJson(String str) => DistrictModel.fromJson(json.decode(str));

String districtModelToJson(DistrictModel data) => json.encode(data.toJson());

class DistrictModel {
  bool status;
  List<District> districtList;

  DistrictModel({
    required this.status,
    required this.districtList,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
    status: json["status"],
    districtList: List<District>.from(json["data"].map((x) => District.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(districtList.map((x) => x.toJson())),
  };
}

class District {
  int id;
  String district;
  String stateId;
  String countryId;
  String status;
  AtedAt createdAt;
  AtedAt updatedAt;

  District({
    required this.id,
    required this.district,
    required this.stateId,
    required this.countryId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
    id: json["id"],
    district: json["district"],
    stateId: json["state_id"],
    countryId: json["country_id"],
    status: json["status"],
    createdAt: atedAtValues.map[json["created_at"]]!,
    updatedAt: atedAtValues.map[json["updated_at"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "district": district,
    "state_id": stateId,
    "country_id": countryId,
    "status": status,
    "created_at": atedAtValues.reverse[createdAt],
    "updated_at": atedAtValues.reverse[updatedAt],
  };
}

enum AtedAt {
  THE_0000011130_T00_0000000000_Z
}

final atedAtValues = EnumValues({
  "-000001-11-30T00:00:00.000000Z": AtedAt.THE_0000011130_T00_0000000000_Z
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

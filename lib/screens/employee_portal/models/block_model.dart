// To parse this JSON data, do
//
//     final blockModel = blockModelFromJson(jsonString);

import 'dart:convert';

BlockModel blockModelFromJson(String str) => BlockModel.fromJson(json.decode(str));

String blockModelToJson(BlockModel data) => json.encode(data.toJson());

class BlockModel {
  bool status;
  List<Block> blockList;

  BlockModel({
    required this.status,
    required this.blockList,
  });

  factory BlockModel.fromJson(Map<String, dynamic> json) => BlockModel(
    status: json["status"],
    blockList: List<Block>.from(json["data"].map((x) => Block.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(blockList.map((x) => x.toJson())),
  };
}

class Block {
  int id;
  String block;
  String status;
  String countryId;
  String stateId;
  String districtId;
  DateTime createdAt;
  DateTime updatedAt;

  Block({
    required this.id,
    required this.block,
    required this.status,
    required this.countryId,
    required this.stateId,
    required this.districtId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Block.fromJson(Map<String, dynamic> json) => Block(
    id: json["id"],
    block: json["block"],
    status: json["status"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    districtId: json["district_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "block": block,
    "status": status,
    "country_id": countryId,
    "state_id": stateId,
    "district_id": districtId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

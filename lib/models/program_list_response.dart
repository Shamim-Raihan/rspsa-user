import 'dart:convert';

ProgramListResponse programListResponseFromJson(String str) => ProgramListResponse.fromJson(json.decode(str));

String programListResponseToJson(ProgramListResponse data) => json.encode(data.toJson());

class ProgramListResponse {
    List<ProgramList>? data;
    String? imagePath;

    ProgramListResponse({
        this.data,
        this.imagePath,
    });

    factory ProgramListResponse.fromJson(Map<String, dynamic> json) => ProgramListResponse(
        data: json["data"] == null ? [] : List<ProgramList>.from(json["data"]!.map((x) => ProgramList.fromJson(x))),
        imagePath: json["image_path"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "image_path": imagePath,
    };
}

class ProgramList {
    int? id;
    String? talentId;
    String? name;
    String? description;
    dynamic image;
    String? amount;
    String? paymentRequired;
    dynamic document;
    String? type;
    String? status;
    String? createdBy;
    DateTime? createdAt;
    DateTime? updatedAt;

    ProgramList({
        this.id,
        this.talentId,
        this.name,
        this.description,
        this.image,
        this.amount,
        this.paymentRequired,
        this.document,
        this.type,
        this.status,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
    });

    factory ProgramList.fromJson(Map<String, dynamic> json) => ProgramList(
        id: json["id"],
        talentId: json["talent_id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        amount: json["amount"],
        paymentRequired: json["payment_required"],
        document: json["document"],
        type: json["type"],
        status: json["status"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "talent_id": talentId,
        "name": name,
        "description": description,
        "image": image,
        "amount": amount,
        "payment_required": paymentRequired,
        "document": document,
        "type": type,
        "status": status,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

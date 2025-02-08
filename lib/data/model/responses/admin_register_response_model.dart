import 'dart:convert';

class AdminRegisterResponseModel {
    final String? message;
    final Admin? data;

    AdminRegisterResponseModel({
        this.message,
        this.data,
    });

    factory AdminRegisterResponseModel.fromJson(String str) => AdminRegisterResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AdminRegisterResponseModel.fromMap(Map<String, dynamic> json) => AdminRegisterResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : Admin.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "data": data?.toMap(),
    };
}

class Admin {
    final String? name;
    final String? email;
    final String? roles;
    final DateTime? updatedAt;
    final DateTime? createdAt;
    final int? id;

    Admin({
        this.name,
        this.email,
        this.roles,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Admin.fromJson(String str) => Admin.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Admin.fromMap(Map<String, dynamic> json) => Admin(
        name: json["name"],
        email: json["email"],
        roles: json["roles"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "roles": roles,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}

// To parse this JSON data, do
//
//     final pathlogy = pathlogyFromJson(jsonString);

import 'dart:convert';

Pathlogy pathlogyFromJson(String str) => Pathlogy.fromJson(json.decode(str));

String pathlogyToJson(Pathlogy data) => json.encode(data.toJson());

class Pathlogy {
  int id;
  bool isActive;
  bool isDelete;
  DateTime createdOn;
  DateTime updatedOn;
  String name;
  String description;
  String address;
  String city;
  String state;
  String zipcode;
  String image;
  dynamic fcmToken;
  String phone;
  String email;
  bool isOffline;
  List<int> workingDays;
  List<DateTime> notWorkingDates;

  Pathlogy({
    required this.id,
    required this.isActive,
    required this.isDelete,
    required this.createdOn,
    required this.updatedOn,
    required this.name,
    required this.description,
    required this.address,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.image,
    required this.fcmToken,
    required this.phone,
    required this.email,
    required this.isOffline,
    required this.workingDays,
    required this.notWorkingDates,
  });

  Pathlogy copyWith({
    int? id,
    bool? isActive,
    bool? isDelete,
    DateTime? createdOn,
    DateTime? updatedOn,
    String? name,
    String? description,
    String? address,
    String? city,
    String? state,
    String? zipcode,
    String? image,
    dynamic fcmToken,
    String? phone,
    String? email,
    bool? isOffline,
    List<int>? workingDays,
    List<DateTime>? notWorkingDates,
  }) =>
      Pathlogy(
        id: id ?? this.id,
        isActive: isActive ?? this.isActive,
        isDelete: isDelete ?? this.isDelete,
        createdOn: createdOn ?? this.createdOn,
        updatedOn: updatedOn ?? this.updatedOn,
        name: name ?? this.name,
        description: description ?? this.description,
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        zipcode: zipcode ?? this.zipcode,
        image: image ?? this.image,
        fcmToken: fcmToken ?? this.fcmToken,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        isOffline: isOffline ?? this.isOffline,
        workingDays: workingDays ?? this.workingDays,
        notWorkingDates: notWorkingDates ?? this.notWorkingDates,
      );

  factory Pathlogy.fromJson(Map<String, dynamic> json) {
    return Pathlogy(
      id: json["id"],
      isActive: json["is_active"],
      isDelete: json["is_delete"],
      createdOn: json["created_on"] != null
          ? DateTime.parse(json["created_on"])
          : DateTime.now(),
      updatedOn: json["updated_on"] != null
          ? DateTime.parse(json["updated_on"])
          : DateTime.now(),
      name: json["name"] ?? "", // Default value "" for empty string
      description:
          json["description"] ?? "", // Default value "" for empty string
      address: json["address"] ?? "", // Default value "" for empty string
      city: json["city"] ?? "", // Default value "" for empty string
      state: json["state"] ?? "", // Default value "" for empty string
      zipcode: json["zipcode"] ?? "", // Default value "" for empty string
      image: json["image"] ?? "", // Default value "" for empty string
      fcmToken: json["fcm_token"] ?? "", // Default value "" for empty string
      phone: json["phone"] ?? "", // Default value "" for empty string
      email: json["email"] ?? "", // Default value "" for empty string
      isOffline: json["is_offline"] ?? false, // Default value false for boolean
      workingDays: json["working_days"] != null
          ? List<int>.from(json["working_days"].map((x) => x))
          : [], // Default value [] for empty list
      notWorkingDates: json["not_working_dates"] != null
          ? List<DateTime>.from(
              json["not_working_dates"].map((x) => DateTime.parse(x)))
          : [], // Default value [] for empty list
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_active": isActive,
        "is_delete": isDelete,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "name": name,
        "description": description,
        "address": address,
        "city": city,
        "state": state,
        "zipcode": zipcode,
        "image": image,
        "fcm_token": fcmToken,
        "phone": phone,
        "email": email,
        "is_offline": isOffline,
        "working_days": List<dynamic>.from(workingDays.map((x) => x)),
        "not_working_dates":
            List<dynamic>.from(notWorkingDates.map((x) => x.toIso8601String())),
      };
}

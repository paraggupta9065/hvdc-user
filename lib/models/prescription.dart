// To parse this JSON data, do
//
//     final prescription = prescriptionFromJson(jsonString);

import 'dart:convert';

import 'package:hvdc_user/models/orders.dart';
import 'package:hvdc_user/models/test.dart';

Prescription prescriptionFromJson(String str) =>
    Prescription.fromJson(json.decode(str));

String prescriptionToJson(Prescription data) => json.encode(data.toJson());

class Prescription {
  int id;
  int total;
  String prescription;
  DateTime dateAdded;
  String promoCode;
  String status;
  int user;
  List<Test> tests;

  Prescription({
    required this.id,
    required this.prescription,
    required this.dateAdded,
    required this.promoCode,
    required this.status,
    required this.user,
    required this.tests,
    required this.total,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
        id: json["id"],
        prescription: json["prescription"],
        dateAdded: DateTime.parse(json["date_added"]),
        promoCode: json["promo_code"],
        status: json["status"],
        user: json["user"],
        tests: List<Test>.from(json["tests"].map((x) => Test.fromJson(x))),
        total: json["total_price"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prescription": prescription,
        "date_added": dateAdded.toIso8601String(),
        "promo_code": promoCode,
        "status": status,
        "user": user,
        "tests": List<dynamic>.from(tests.map((x) => x)),
      };
}

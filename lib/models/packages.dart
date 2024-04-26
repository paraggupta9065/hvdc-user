import 'dart:convert';

import 'package:hvdc_user/models/test.dart';

class Packages {
  int id;
  List<PackageTest> tests;
  String name;
  String description;
  int regularPrice;
  int price;
  int pathology;
  int category;

  Packages({
    required this.id,
    required this.tests,
    required this.name,
    required this.description,
    required this.regularPrice,
    required this.price,
    required this.pathology,
    required this.category,
  });

  Packages copyWith({
    int? id,
    List<PackageTest>? tests,
    String? name,
    String? description,
    int? regularPrice,
    int? price,
    int? pathology,
    int? category,
  }) =>
      Packages(
        id: id ?? this.id,
        tests: tests ?? this.tests,
        name: name ?? this.name,
        description: description ?? this.description,
        regularPrice: regularPrice ?? this.regularPrice,
        price: price ?? this.price,
        pathology: pathology ?? this.pathology,
        category: category ?? this.category,
      );

  factory Packages.fromJson(Map<String, dynamic> json) => Packages(
        id: json["id"],
        tests: List<PackageTest>.from(
            json["tests"].map((x) => PackageTest.fromJson(x))),
        name: json["name"],
        description: json["description"],
        regularPrice: json["regular_price"],
        price: json["price"],
        pathology: json["pathology"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tests": List<dynamic>.from(tests.map((x) => x.toJson())),
        "name": name,
        "description": description,
        "regular_price": regularPrice,
        "price": price,
        "pathology": pathology,
        "category": category,
      };
}

class PackageTest {
  String name;
  String description;

  PackageTest({
    required this.name,
    required this.description,
  });

  PackageTest copyWith({
    String? name,
    String? description,
  }) =>
      PackageTest(
        name: name ?? this.name,
        description: description ?? this.description,
      );

  factory PackageTest.fromJson(Map<String, dynamic> json) => PackageTest(
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
      };
}

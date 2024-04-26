// To parse this JSON data, do
//
//     final test = testFromJson(jsonString);

import 'dart:convert';

class Test {
  int id;
  bool inCart;
  String name;
  String description;
  String testType;
  int regularPrice;
  int price;
  bool isOffline;
  String fasting;
  String gender;
  String age;
  String reportTime;
  int pathology;
  int category;
  List<dynamic> pathologyList;

  Test({
    required this.id,
    required this.inCart,
    required this.name,
    required this.description,
    required this.testType,
    required this.regularPrice,
    required this.price,
    required this.isOffline,
    required this.fasting,
    required this.gender,
    required this.age,
    required this.reportTime,
    required this.pathology,
    required this.category,
    required this.pathologyList,
  });

  Test copyWith({
    int? id,
    bool? inCart,
    String? name,
    String? description,
    String? testType,
    int? regularPrice,
    int? price,
    bool? isOffline,
    String? fasting,
    String? gender,
    String? age,
    String? reportTime,
    int? pathology,
    int? category,
    List<dynamic>? pathologyList,
  }) =>
      Test(
        id: id ?? this.id,
        inCart: inCart ?? this.inCart,
        name: name ?? this.name,
        description: description ?? this.description,
        testType: testType ?? this.testType,
        regularPrice: regularPrice ?? this.regularPrice,
        price: price ?? this.price,
        isOffline: isOffline ?? this.isOffline,
        fasting: fasting ?? this.fasting,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        reportTime: reportTime ?? this.reportTime,
        pathology: pathology ?? this.pathology,
        category: category ?? this.category,
        pathologyList: pathologyList ?? this.pathologyList,
      );

  factory Test.fromJson(Map<String, dynamic> json) => Test(
        id: json["id"],
        inCart: json["in_cart"],
        name: json["name"],
        description: json["description"],
        testType: json["test_type"],
        regularPrice: json["regular_price"],
        price: json["price"],
        isOffline: json["is_offline"],
        fasting: json["fasting"],
        gender: json["gender"],
        age: json["age"],
        reportTime: json["report_time"],
        pathology: json["pathology"],
        category: json["category"],
        pathologyList: List<dynamic>.from(json["pathology_list"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "in_cart": inCart,
        "name": name,
        "description": description,
        "test_type": testType,
        "regular_price": regularPrice,
        "price": price,
        "is_offline": isOffline,
        "fasting": fasting,
        "gender": gender,
        "age": age,
        "report_time": reportTime,
        "pathology": pathology,
        "category": category,
        "pathology_list": List<dynamic>.from(pathologyList.map((x) => x)),
      };
}

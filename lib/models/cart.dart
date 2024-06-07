// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'package:hvdc_user/models/packages.dart';

import 'test.dart';

class CartModel {
  CartClass cart;
  num cartTotal;

  CartModel({
    required this.cart,
    required this.cartTotal,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        cart: CartClass.fromJson(json["cart"]),
        cartTotal: json["cart_total"],
      );

  Map<String, dynamic> toJson() => {
        "cart": cart.toJson(),
        "cart_total": cartTotal,
      };
}

class CartClass {
  int id;
  List<Test> tests;
  List<Packages> packages;
  DateTime dateAdded;
  int user;
  Promocode? promocode;
  double total_price;
  double discount;
  double normal_price;

  CartClass(
      {required this.id,
      required this.tests,
      required this.dateAdded,
      required this.user,
      required this.packages,
      this.promocode,
      required this.discount,
      required this.normal_price,
      required this.total_price});

  factory CartClass.fromJson(Map<String, dynamic> json) => CartClass(
        id: json["id"],
        discount: json["discount"],
        normal_price: json["normal_price"],
        total_price: json["total_price"],
        tests: List<Test>.from(json["tests"].map((x) => Test.fromJson(x))),
        packages: List<Packages>.from(
            json["packages"].map((x) => Packages.fromJson(x))),
        dateAdded: DateTime.parse(json["date_added"]),
        user: json["user"],
        promocode: json["promocode"] == null
            ? null
            : Promocode.fromJson(json["promocode"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tests": List<dynamic>.from(tests.map((x) => x.toJson())),
        "date_added": dateAdded.toIso8601String(),
        "user": user,
      };
}

class Promocode {
  int id;
  String code;
  String discountPercentage;
  DateTime validFrom;
  DateTime validTo;
  bool active;

  Promocode({
    required this.id,
    required this.code,
    required this.discountPercentage,
    required this.validFrom,
    required this.validTo,
    required this.active,
  });

  factory Promocode.fromJson(Map<String, dynamic> json) => Promocode(
        id: json["id"],
        code: json["code"],
        discountPercentage: json["discount_percentage"],
        validFrom: DateTime.parse(json["valid_from"]),
        validTo: DateTime.parse(json["valid_to"]),
        active: json["active"],
      );
}

// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'package:hvdc_user/models/packages.dart';

import 'test.dart';

class CartModel {
  CartClass cart;
  int cartTotal;

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

  CartClass({
    required this.id,
    required this.tests,
    required this.dateAdded,
    required this.user,
    required this.packages,
  });

  factory CartClass.fromJson(Map<String, dynamic> json) => CartClass(
        id: json["id"],
        tests: List<Test>.from(json["tests"].map((x) => Test.fromJson(x))),
        packages: List<Packages>.from(
            json["packages"].map((x) => Packages.fromJson(x))),
        dateAdded: DateTime.parse(json["date_added"]),
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tests": List<dynamic>.from(tests.map((x) => x.toJson())),
        "date_added": dateAdded.toIso8601String(),
        "user": user,
      };
}

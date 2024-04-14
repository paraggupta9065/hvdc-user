// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

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
  DateTime dateAdded;
  int user;

  CartClass({
    required this.id,
    required this.tests,
    required this.dateAdded,
    required this.user,
  });

  factory CartClass.fromJson(Map<String, dynamic> json) => CartClass(
        id: json["id"],
        tests: List<Test>.from(json["tests"].map((x) => Test.fromJson(x))),
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

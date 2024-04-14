import 'package:flutter/material.dart';
import 'package:hvdc_user/utils/card.dart';

import 'colors.dart';
import 'style.dart';

class KTextField extends StatelessWidget {
  const KTextField(
      {super.key, required this.controller, required this.hintText});

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return kContainer(
      child: TextField(
        controller: controller,
        style: kTextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: kTextStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'style.dart';

AppBar KAppBar(String title) {
  return AppBar(
    title: Text(
      title,
      style: kTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

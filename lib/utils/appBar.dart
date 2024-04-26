import 'package:flutter/material.dart';

import 'style.dart';

AppBar KAppBar(String title, {List<Widget>? actions}) {
  return AppBar(
    title: Text(
      title,
      style: kTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    ),
    actions: actions,
  );
}

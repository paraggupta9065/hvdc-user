import 'package:flutter/cupertino.dart';
import 'package:hvdc_user/utils/colors.dart';

Container kContainer({
  required Widget child,
  double? width,
  double? height,
  Color color = kWhite,
}) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      border: Border.all(
        color: kWhite,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: kText.withOpacity(0.1),
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    height: height,
    width: width,
    child: child,
  );
}

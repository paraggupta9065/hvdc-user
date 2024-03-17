import 'package:flutter/cupertino.dart';

Container kContainer({
  required Widget child,
  double? width,
  double? height,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color(0xFFF1F1F1),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(12),
      color: const Color(0xFFFFFFFF),
      boxShadow: const [
        BoxShadow(
          color: Color(0x1A2F2B43),
          blurRadius: 3,
          offset: Offset(0, 1),
        ),
      ],
    ),
    height: height,
    width: width,
    child: child,
  );
}

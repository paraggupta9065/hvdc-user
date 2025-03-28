import 'package:flutter/material.dart';
import 'package:hvdc_user/utils/colors.dart';
import 'package:lottie/lottie.dart';

class KLoading extends StatelessWidget {
  const KLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset('assets/animation/loading.json', height: 150));
  }
}

class KLoadingCircular extends StatelessWidget {
  const KLoadingCircular({super.key, this.color = kGreen});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: color,
    ));
  }
}

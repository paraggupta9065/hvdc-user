import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_strategy/url_strategy.dart';
import 'utils/routing.dart';
import 'utils/style.dart';

void main() async {
  setPathUrlStrategy();
  await init();
  runApp(const MyApp());
}

init() async {
  await Hive.initFlutter();
  await Hive.openBox("user");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HVDC',
      theme: themeData,
      getPages: getRoutes,
      initialRoute: '/home',
    );
  }
}

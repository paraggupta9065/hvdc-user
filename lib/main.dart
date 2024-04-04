import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'utils/routing.dart';
import 'utils/style.dart';

void main() async {
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
      home: MaterialApp.router(
        title: 'HVDC',
        theme: themeData,
        routerConfig: router,
      ),
    );
  }
}

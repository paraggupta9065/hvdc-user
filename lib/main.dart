import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hvdc_user/screens/book_a_test.dart';
import 'package:hvdc_user/screens/cart.dart';
import 'package:hvdc_user/screens/search_page.dart';

import 'screens/notification.dart';
import 'utils/routing.dart';
import 'utils/style.dart';

void main() {
  runApp(const MyApp());
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hvdc_user/controllers/auth_controller.dart';
import 'package:hvdc_user/controllers/homepage_controller.dart';
import 'package:hvdc_user/screens/home/mobile_home.dart';
import 'package:hvdc_user/screens/home/web_home.dart';
import 'package:hvdc_user/utils/articles.dart';
import 'package:hvdc_user/utils/colors.dart';
import 'package:hvdc_user/utils/urls.dart';

import '../../controllers/article_controller.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final HomepageController homepageController = Get.put(HomepageController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !context.isPhone ? const WebHome() : const MobileHome();
  }
}

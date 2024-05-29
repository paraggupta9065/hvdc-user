import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hvdc_user/screens/auth/signup.dart';
import 'package:hvdc_user/screens/book_a_test.dart';
import 'package:hvdc_user/screens/book_apointment/book_apointment_page.dart';
import 'package:hvdc_user/screens/bookings.dart';
import 'package:hvdc_user/screens/bottom_navigation_page.dart';
import 'package:hvdc_user/screens/cart/cart.dart';
import 'package:hvdc_user/screens/list_tests.dart';
import 'package:hvdc_user/screens/notification.dart';
import 'package:hvdc_user/screens/onboarding/onboarding.dart';
import 'package:hvdc_user/screens/prescription_list.dart';
import 'package:hvdc_user/screens/profile_screens/profile_page.dart';
import 'package:hvdc_user/screens/profile_screens/test_booking_screen.dart';
import 'package:hvdc_user/screens/search_page.dart';
import 'package:hvdc_user/screens/upload_prescription.dart';
import 'package:hvdc_user/screens/upload_prescription_web.dart';
import 'package:hvdc_user/utils/article.dart';
import 'package:hvdc_user/utils/articles.dart';
import '../controllers/auth_controller.dart';
import '../screens/cart/web_cart.dart';
import '../screens/home/homepage.dart';
import 'responsive.dart';

final getRoutes = [
  GetPage(
    name: '/sign-up',
    page: () => const SignUp(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: '/onboarding',
    page: () => const Onbording(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: '/',
    page: () =>
        const Scaffold(body: Center(child: Text('Something went wrong!'))),
    children: [
      GetPage(
        name: '/home',
        page: () => kWeb ? const MainHome() : const BottomNavigator(),
      ),
      GetPage(
        name: '/profile',
        page: () => ProfilePage(),
        children: [
          GetPage(
            name: '/test-booking',
            page: () => const TestBookingScreen(),
          ),
        ],
        middlewares: [WebLogoutMiddleware()],
      ),
      GetPage(
        name: '/search',
        page: () => const SearchPage(),
      ),
      GetPage(
        name: '/appointment_booking',
        page: () => const AppointmentBookingScreen(),
        middlewares: [WebLogoutMiddleware()],
      ),
      GetPage(
        name: '/book-a-test',
        page: () => const BookATest(),
      ),
      GetPage(
        name: '/tests',
        page: () => ListTests(
          categoryId: Get.parameters['category_id'] ?? '',
          categoryName: Get.parameters['category_name'] ?? '',
        ),
      ),
      GetPage(
        name: '/notification',
        page: () => const Notifications(),
        middlewares: [WebLogoutMiddleware()],
      ),
      GetPage(
        name: '/cart',
        page: () => kWeb ? const WebCart() : const Cart(),
        middlewares: [WebLogoutMiddleware()],
      ),
      GetPage(
        name: '/articles',
        page: () => const Articles(),
      ),
      GetPage(
        name: '/article/:id',
        page: () => Article(id: int.parse(Get.parameters['id']!)),
      ),
      GetPage(
        name: '/bookings',
        page: () => const Bookings(),
        middlewares: [WebLogoutMiddleware()],
      ),
      GetPage(
        name: '/upload_prescription',
        page: () => kWeb
            ? const UploadPrescriptionScreenWeb()
            : const UploadPrescriptionScreen(),
        middlewares: [WebLogoutMiddleware()],
      ),
      GetPage(
        name: '/prescription_list',
        page: () => const PrescriptionList(),
        middlewares: [WebLogoutMiddleware()],
      ),
    ],
  ),
];

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    AuthController authController = Get.put(AuthController());
    bool isLogin = authController.isLogin();

    if (route == '/sign-up' && isLogin) {
      return const RouteSettings(name: '/home');
    } else if (route == '/onboarding' && isLogin && !kWeb) {
      return const RouteSettings(name: '/home');
    } else if (route == '/' && !isLogin && !kWeb) {
      return const RouteSettings(name: '/sign-up');
    }
    return null;
  }
}

class WebLogoutMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    AuthController authController = Get.put(AuthController());
    bool isLogin = authController.isLogin();

    if (kWeb && !isLogin) {
      return const RouteSettings(name: '/sign-up');
    }
    return null;
  }
}

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hvdc_user/screens/auth/signup.dart';
import 'package:hvdc_user/screens/book_a_test.dart';
import 'package:hvdc_user/screens/book_apointment/book_apointment_page.dart';
import 'package:hvdc_user/screens/bottom_navigation_page.dart';
import 'package:hvdc_user/screens/cart.dart';
import 'package:hvdc_user/screens/list_tests.dart';
import 'package:hvdc_user/screens/notification.dart';
import 'package:hvdc_user/screens/onboarding/onboarding.dart';
import 'package:hvdc_user/screens/profile_screens/profile_page.dart';
import 'package:hvdc_user/screens/profile_screens/test_booking_screen.dart';
import 'package:hvdc_user/screens/search_page.dart';
import 'package:hvdc_user/utils/article.dart';
import 'package:hvdc_user/utils/articles.dart';

import '../controllers/auth_controller.dart';
import '../screens/home/homepage.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: kIsWeb ? '/home' : "/onbording",
  routes: [
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => const SignUp(),
      redirect: (context, state) {
        AuthController authController = Get.put(AuthController());
        bool isLogin = authController.isLogin();
        if (isLogin) {
          return "/home";
        }
        return null;
      },
    ),
    GoRoute(
      path: '/onbording',
      builder: (context, state) => const Onbording(),
      redirect: (context, state) {
        AuthController authController = Get.put(AuthController());
        bool isLogin = authController.isLogin();
        if (isLogin && !kIsWeb) {
          return "/home";
        }
        return null;
      },
    ),
    GoRoute(
        path: '/',
        redirect: (context, state) {
          AuthController authController = Get.put(AuthController());
          bool isLogin = authController.isLogin();
          if (!isLogin && !kIsWeb) {
            return "/sign-up";
          }
          return null;
        },
        routes: [
          GoRoute(
            path: 'home',
            builder: (context, state) =>
                kIsWeb ? const MainHome() : const BottomNavigator(),
          ),
          GoRoute(
            path: 'profile',
            builder: (context, state) => ProfilePage(),
            routes: [
              GoRoute(
                path: 'test-booking',
                builder: (context, state) => const TestBookingScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'search',
            builder: (context, state) => const SearchPage(),
          ),
          GoRoute(
            path: 'appointment_booking',
            builder: (context, state) => const AppointmentBookingScreen(),
          ),
          GoRoute(
            path: 'search',
            builder: (context, state) => const SearchPage(),
          ),
          GoRoute(
            path: 'book-a-test',
            builder: (context, state) => const BookATest(),
          ),
          GoRoute(
            path: 'tests',
            builder: (context, state) => ListTests(
              categoryId: state.uri.queryParameters['category_id'] ?? "",
              categoryName: state.uri.queryParameters['category_name'] ?? "",
            ),
          ),
          GoRoute(
            path: 'notification',
            builder: (context, state) => const Notifications(),
          ),
          GoRoute(
            path: 'cart',
            builder: (context, state) => const Cart(),
          ),
          GoRoute(
            path: 'articles',
            builder: (context, state) => const Articles(),
          ),
          GoRoute(
            path: 'article/:id',
            builder: (context, state) =>
                Article(id: int.parse(state.pathParameters['id']!)),
          ),
        ]),
  ],
);

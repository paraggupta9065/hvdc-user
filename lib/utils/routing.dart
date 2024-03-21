import 'package:go_router/go_router.dart';
import 'package:hvdc_user/screens/auth/signup.dart';
import 'package:hvdc_user/screens/book_a_test.dart';
import 'package:hvdc_user/screens/bottom_navigation_page.dart';
import 'package:hvdc_user/screens/cart.dart';
import 'package:hvdc_user/screens/notification.dart';
import 'package:hvdc_user/screens/onboarding/onboarding.dart';
import 'package:hvdc_user/screens/profile_screens/profile_page.dart';
import 'package:hvdc_user/screens/profile_screens/test_booking_screen.dart';
import 'package:hvdc_user/screens/search_page.dart';
import 'package:hvdc_user/utils/articles.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => const SignUp(),
    ),
    GoRoute(path: '/', builder: (context, state) => const Onbording(), routes: [
      GoRoute(
        path: 'home',
        builder: (context, state) => BottomNavigator(),
      ),
      GoRoute(
        path: 'profile',
        builder: (context, state) => ProfilePage(),
        routes: [
          GoRoute(
            path: 'test-booking', // Removed leading '/' from nested route path
            builder: (context, state) => TestBookingScreen(),
          ),
        ],
      ),
      GoRoute(
        path: 'search',
        builder: (context, state) => const SearchPage(),
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
    ]),
  ],
);

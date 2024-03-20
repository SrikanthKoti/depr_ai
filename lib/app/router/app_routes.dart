import 'package:depr_ai/app/router/app_pages.dart';
import 'package:depr_ai/pages/home_page.dart';
import 'package:depr_ai/pages/onboarding_page.dart';
import 'package:depr_ai/pages/splash.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppPages.pageSplash:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case AppPages.pageHome:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case AppPages.pageOnboarding:
        return MaterialPageRoute(builder: (context) => const OnboardingPage());
      default:
        throw ('This route name does not exist');
    }
  }
}

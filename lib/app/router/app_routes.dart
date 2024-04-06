import 'package:depr_ai/app/router/app_pages.dart';
import 'package:depr_ai/datasource/submit_questioner_datasource.dart';
import 'package:depr_ai/pages/chart_page.dart';
import 'package:depr_ai/pages/home_page.dart';
import 'package:depr_ai/pages/onboarding_page.dart';
import 'package:depr_ai/pages/score_page.dart';
import 'package:depr_ai/pages/splash.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      case AppPages.pageSplash:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case AppPages.pageHome:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case AppPages.pageOnboarding:
        return MaterialPageRoute(builder: (context) => const OnboardingPage());
      case AppPages.pageChart:
        return MaterialPageRoute(builder: (context) => const ChartPage());
      case AppPages.pageScore:
        var args = settings.arguments != null ? settings.arguments as Map<String, dynamic> : {};
        return MaterialPageRoute(
          builder: (context) => ScorePage(
            scoreData: args.containsKey("scoreData") ? args["scoreData"] : {},
          ),
        );
      default:
        throw ('This route name does not exist');
    }
  }
}

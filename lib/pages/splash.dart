import 'package:depr_ai/app/constants/app_colors.dart';
import 'package:depr_ai/app/constants/app_styles.dart';
import 'package:depr_ai/app/router/app_pages.dart';
import 'package:depr_ai/app/router/custom_navigator.dart';
import 'package:depr_ai/app/utils.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      Utils.printLogs('Splash for few seconds !!!');
      CustomNavigator.popUntilFirstAndPush(context, AppPages.pageOnboarding);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.C3E9E4,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "EmoScore",
              textAlign: TextAlign.center,
              style: AppStyles.s64_bold_black,
            )
          ],
        ),
      ),
    );
  }
}

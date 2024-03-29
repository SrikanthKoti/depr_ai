import 'package:depr_ai/app/constants/app_colors.dart';
import 'package:depr_ai/app/constants/app_images.dart';
import 'package:depr_ai/app/constants/app_styles.dart';
import 'package:depr_ai/app/constants/custom_spacers.dart';
import 'package:depr_ai/app/router/app_pages.dart';
import 'package:depr_ai/app/router/custom_navigator.dart';
import 'package:depr_ai/ui/atoms/floating_next_button.dart';
import 'package:depr_ai/ui/atoms/image_icon_view.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.C3E9E4,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ImageIconView(
                assetPath: AppImages.IMG_DOCTOR,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(color: AppColors.WHITE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSpacers.height24,
                  Text(
                    'Answer the Questionnaire To determine your Depression level',
                    style: AppStyles.s36_w500_black,
                  ),
                  Text(
                    "Let's journey together towards understanding.",
                    style: AppStyles.s16_w500_747474,
                  ),
                  CustomSpacers.height24,
                  FloatingNextButton(
                    isDisabled: false,
                    onTap: () {
                      CustomNavigator.popUntilFirstAndPush(context, AppPages.pageHome);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

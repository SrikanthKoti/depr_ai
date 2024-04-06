import 'package:depr_ai/app/constants/app_colors.dart';
import 'package:depr_ai/app/constants/app_images.dart';
import 'package:depr_ai/app/constants/app_styles.dart';
import 'package:depr_ai/app/constants/custom_spacers.dart';
import 'package:depr_ai/app/router/app_pages.dart';
import 'package:depr_ai/app/router/custom_navigator.dart';
import 'package:depr_ai/data/submit_questioner_response_model.dart';
import 'package:depr_ai/ui/atoms/floating_next_button.dart';
import 'package:depr_ai/ui/atoms/image_icon_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ScorePage extends StatefulWidget {
  final SubmitQuestionerResponse scoreData;
  const ScorePage({super.key, required this.scoreData});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

String _getAsset(String status) {
  switch (status) {
    case "Normal":
      return AppImages.IMG_NORMAL;
    case "Extremely Severe Depression":
      return AppImages.IMG_Extremely_Severe_Depression;
    case "Mild Depression":
      return AppImages.IMG_Mild_Depression;
    case "Moderate Depression":
      return AppImages.IMG_Moderate_Depression;
    case "Severe Depression":
      return AppImages.IMG_Severe_Depression;
    default:
      return AppImages.IMG_NORMAL;
  }
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingNextButton(
          isDisabled: false,
          btnText: "Retake test",
          onTap: () async {
            CustomNavigator.popUntilFirstAndPush(context, AppPages.pageHome);
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    color: AppColors.C3E9E4,
                    // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 32.h, bottom: 32.h),
                          child: CircularStepProgressIndicator(
                            totalSteps: 100,
                            currentStep: 74,
                            stepSize: 10,
                            selectedColor: AppColors.C_28CBB0,
                            unselectedColor: Colors.grey[200],
                            padding: 0,
                            width: 150.w,
                            height: 150.h,
                            selectedStepSize: 15,
                            child: Center(
                              child: Text(
                                widget.scoreData.score.toString(),
                                style: AppStyles.s60_w700_black,
                              ),
                            ),
                            roundedCap: (_, __) => true,
                          ),
                        ),
                        ImageIconView(
                          assetPath: _getAsset(widget.scoreData.status),
                          dHeight: 150.h,
                          dWidth: 150.w,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24.h, right: 12.w),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton.filled(
                        onPressed: () {
                          CustomNavigator.pushTo(context, AppPages.pageChart);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => AppColors.F6A5CA,
                          ),
                          shape: MaterialStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                        icon: Icon(
                          Icons.stacked_line_chart_rounded,
                          size: 32.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              CustomSpacers.height16,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('You suffered from:', style: AppStyles.s16_w500_747474),
                    CustomSpacers.height4,
                    Text(widget.scoreData.status, style: AppStyles.s20_w500_black),
                    CustomSpacers.height12,
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: AppColors.C_28CBB0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomSpacers.height12,
                              Text(
                                "Advices",
                                style: AppStyles.s32_w700_white,
                              ),
                              CustomSpacers.height12,
                              Text(
                                widget.scoreData.advice,
                                style: AppStyles.s16_w500_white,
                              ),
                              CustomSpacers.height12,
                            ],
                          ),
                        ),
                      ),
                    ),
                    CustomSpacers.height200,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

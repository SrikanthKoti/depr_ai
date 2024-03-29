import 'package:depr_ai/app/constants/app_colors.dart';
import 'package:depr_ai/app/constants/app_images.dart';
import 'package:depr_ai/app/constants/app_styles.dart';
import 'package:depr_ai/app/constants/custom_spacers.dart';
import 'package:depr_ai/app/router/app_pages.dart';
import 'package:depr_ai/app/router/custom_navigator.dart';
import 'package:depr_ai/data/question_model.dart';
import 'package:depr_ai/helper.dart';
import 'package:depr_ai/ui/atoms/floating_next_button.dart';
import 'package:depr_ai/ui/atoms/image_icon_view.dart';
import 'package:depr_ai/ui/atoms/option.dart';
import 'package:depr_ai/ui/atoms/progress_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Question> questions = Helper.getQuestions();
  int currentQue = 0;
  void _onbackPress() {
    if (currentQue == 0) {
      // CustomNavigator.pop(context);
    } else {
      setState(() {
        currentQue -= 1;
      });
    }
  }

  void _onTapNext() {
    if ((currentQue + 1) < questions.length) {
      setState(() {
        currentQue += 1;
      });
    } else {
      List<int?> answers = questions.map((que) => que.selectedIndex).toList();
      CustomNavigator.popUntilFirstAndPush(
        context,
        AppPages.pageScore,
        arguments: {"answers": answers},
      );
    }
  }

  void _onOptionSelect(int optionIndex) {
    setState(() {
      questions[currentQue].selectedIndex = optionIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (b) {
        _onbackPress();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.WHITE,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingNextButton(
            isDisabled: questions[currentQue].selectedIndex == null,
            onTap: _onTapNext,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: AppColors.C3E9E4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (currentQue != 0)
                              GestureDetector(
                                onTap: () {
                                  _onbackPress();
                                },
                                child: Row(
                                  children: [
                                    const ImageIconView(
                                      assetPath: AppImages.ICON_BACK,
                                      iconColor: AppColors.BLACK,
                                      dHeight: 12,
                                      dWidth: 16,
                                    ),
                                    CustomSpacers.width2,
                                    Text(
                                      "Back",
                                      style: AppStyles.s16_w500_black,
                                    )
                                  ],
                                ),
                              ),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  text: "${currentQue + 1}",
                                  style: AppStyles.s16_blod_black,
                                  children: [
                                    TextSpan(
                                      text: "  of ${questions.length}",
                                      style: AppStyles.s16_w400_black,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ProgressBar(
                          dValue: (currentQue + 1) / questions.length,
                          dHeight: 3,
                          progressBarSize: ProgressBarSizes.small,
                          bShowLabel: true,
                          showLabelToTheRight: true,
                          labelRightMargin: 0,
                          progressBarRightMargin: 0,
                          progressBarLeftMargin: 0,
                          progressPaintStyle: PaintingStyle.stroke,
                          progressStrokeWidth: 4,
                        ),
                      ),
                      CustomSpacers.height36,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          questions[currentQue].question,
                          style: AppStyles.s36_w500_black,
                        ),
                      ),
                      CustomSpacers.height14,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "Select any one",
                          style: AppStyles.s16_w500_747474,
                        ),
                      ),
                      CustomSpacers.height16,
                    ],
                  ),
                ),
                CustomSpacers.height40,
                ...List.generate(questions[currentQue].answers.length, (index) {
                  String option = questions[currentQue].answers[index];
                  bool isSelected = index == questions[currentQue].selectedIndex;
                  return Option(
                    onTap: () {
                      _onOptionSelect(index);
                    },
                    isSelected: isSelected,
                    option: option,
                  );
                }),
                CustomSpacers.height74,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

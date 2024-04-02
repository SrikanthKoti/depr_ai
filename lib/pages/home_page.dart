import 'package:depr_ai/app/constants/app_colors.dart';
import 'package:depr_ai/app/constants/app_images.dart';
import 'package:depr_ai/app/constants/app_styles.dart';
import 'package:depr_ai/app/constants/custom_spacers.dart';
import 'package:depr_ai/app/custom_http_client.dart';
import 'package:depr_ai/app/router/app_pages.dart';
import 'package:depr_ai/app/router/custom_navigator.dart';
import 'package:depr_ai/data/question_model.dart';
import 'package:depr_ai/data/submit_questioner_request_model.dart';
import 'package:depr_ai/data/submit_questioner_response_model.dart';
import 'package:depr_ai/datasource/response.dart';
import 'package:depr_ai/datasource/submit_questioner_datasource.dart';
import 'package:depr_ai/helper.dart';
import 'package:depr_ai/ui/atoms/floating_next_button.dart';
import 'package:depr_ai/ui/atoms/image_icon_view.dart';
import 'package:depr_ai/ui/atoms/option.dart';
import 'package:depr_ai/ui/atoms/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Question> questions = Helper.getQuestions();
  int currentQue = 0;
  final CustomHttpClient client = CustomHttpClient();
  late SubmitQuestionerDataSource submitQuestionerDataSource;
  SubmitQuestionerRequestModel request = SubmitQuestionerRequestModel(
      age: 0, gender: '', maritalStatus: '', employmentStatus: '', options: []);
  @override
  void initState() {
    client.initialise();
    submitQuestionerDataSource = SubmitQuestionerDataSource(client: client);
    super.initState();
  }

  void _onbackPress() {
    if (currentQue == 0) {
      // CustomNavigator.pop(context);
    } else {
      setState(() {
        currentQue -= 1;
      });
    }
  }

  void _onOptionSelect(int optionIndex) {
    switch (questions[currentQue].type) {
      case QuestionType.age:
        if (optionIndex >= 0 && optionIndex <= 100) {
          request.age = optionIndex;
        } else {
          request.age = 0;
          Fluttertoast.showToast(
            msg: "Invalid age entered",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }

        break;
      case QuestionType.gender:
        request.gender = questions[currentQue].answers[optionIndex];
        questions[currentQue].selectedIndex = optionIndex;
        break;
      case QuestionType.maritalStatus:
        request.maritalStatus = questions[currentQue].answers[optionIndex];
        questions[currentQue].selectedIndex = optionIndex;
        break;
      case QuestionType.employmentStatus:
        request.employmentStatus = questions[currentQue].answers[optionIndex];
        questions[currentQue].selectedIndex = optionIndex;
        break;
      default:
        questions[currentQue].selectedIndex = optionIndex;
        break;
    }
    setState(() {});
  }

  bool _nextBtnIsDisabled() {
    switch (questions[currentQue].type) {
      case QuestionType.age:
        return request.age == 0;
      case QuestionType.gender:
        return request.gender.isEmpty;
      case QuestionType.maritalStatus:
        return request.maritalStatus.isEmpty;
      case QuestionType.employmentStatus:
        return request.employmentStatus.isEmpty;
      default:
        return questions[currentQue].selectedIndex == null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: PopScope(
        canPop: false,
        onPopInvoked: (b) {
          _onbackPress();
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.WHITE,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingNextButton(
              isDisabled: _nextBtnIsDisabled(),
              onTap: () async {
                if ((currentQue + 1) < questions.length) {
                  setState(() {
                    currentQue += 1;
                  });
                } else {
                  request.options =
                      questions.map((que) => que.selectedIndex ?? 0).toList().sublist(4);

                  context.loaderOverlay.show();

                  Response res = await submitQuestionerDataSource.dataSourceMethod(request);

                  if (res.isSuccess) {
                    if (context.mounted) {
                      context.loaderOverlay.hide();
                      CustomNavigator.popUntilFirstAndPush(
                        context,
                        AppPages.pageScore,
                        arguments: {"scoreData": res.data as SubmitQuestionerResponse},
                      );
                    }
                  } else {
                    Fluttertoast.showToast(
                      msg: res.errorMsg,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                  if (context.mounted) {
                    context.loaderOverlay.hide();
                  }

                  setState(() {});
                }
              },
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
                            questions[currentQue].type != QuestionType.age
                                ? "Select any one"
                                : "Please enter your age (1 to 100)",
                            style: AppStyles.s16_w500_747474,
                          ),
                        ),
                        CustomSpacers.height16,
                      ],
                    ),
                  ),
                  CustomSpacers.height40,
                  if (questions[currentQue].type != QuestionType.age)
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
                  if (questions[currentQue].type == QuestionType.age)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          _onOptionSelect(int.tryParse(val) ?? 0);
                        },
                        decoration: const InputDecoration(
                          hintText: "Age",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.C_28CBB0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.DADADA),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  CustomSpacers.height74,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

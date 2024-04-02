import 'package:depr_ai/app/constants/app_colors.dart';
import 'package:depr_ai/app/constants/app_images.dart';
import 'package:depr_ai/app/constants/app_styles.dart';
import 'package:depr_ai/app/constants/custom_spacers.dart';
import 'package:depr_ai/app/custom_http_client.dart';
import 'package:depr_ai/app/router/app_pages.dart';
import 'package:depr_ai/app/router/custom_navigator.dart';
import 'package:depr_ai/datasource/flag_questioner_datasource.dart';
import 'package:depr_ai/ui/atoms/floating_next_button.dart';
import 'package:depr_ai/ui/atoms/image_icon_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../datasource/response.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final CustomHttpClient client = CustomHttpClient();
  late FlagQuestionerDataSource falgDataSource;
  bool hasPaidMoney = true;
  @override
  void initState() {
    client.initialise();
    falgDataSource = FlagQuestionerDataSource(client: client);

    super.initState();
  }

  void callMoneyFlag() async {
    Response res = await falgDataSource.dataSourceMethod();
    if (res.isSuccess) {
      setState(() {
        hasPaidMoney = res.data;
      });
    }
    if (hasPaidMoney) {
      if (context.mounted) {
        CustomNavigator.popUntilFirstAndPush(context, AppPages.pageHome);
      }
    } else {
      Fluttertoast.showToast(
        msg: "Something went wrong",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.C3E9E4,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Center(
                child: ImageIconView(
                  assetPath: AppImages.IMG_DOCTOR,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: const BoxDecoration(color: AppColors.WHITE),
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
                        callMoneyFlag();
                      },
                      btnText: "Start",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

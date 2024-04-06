import 'package:depr_ai/app/constants/app_colors.dart';
import 'package:depr_ai/app/constants/app_images.dart';
import 'package:depr_ai/app/constants/app_styles.dart';
import 'package:depr_ai/app/constants/custom_spacers.dart';
import 'package:depr_ai/app/custom_http_client.dart';
import 'package:depr_ai/app/router/custom_navigator.dart';
import 'package:depr_ai/data/chart_data.dart';
import 'package:depr_ai/data/submit_questioner_response_model.dart';
import 'package:depr_ai/datasource/get_chart_data_datasource.dart';
import 'package:depr_ai/datasource/response.dart';
import 'package:depr_ai/ui/atoms/image_icon_view.dart';
import 'package:depr_ai/ui/chart/custom_bubble_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final CustomHttpClient client = CustomHttpClient();
  late GetChartDataDataSource getChartDataDataSource;
  bool isLoading = true;
  List<SubmitQuestionerResponse> chartData = [];

  //----- Gender Data
  List<BubbleSeries<ChartData, num>> genderBubbleSeries = [];

  List<ChartData> maleData = [];
  List<ChartData> femaleData = [];
  List<ChartData> othersData = [];

  void addGenderDataToList() {
    genderBubbleSeries = [
      BubbleSeries<ChartData, num>(
        opacity: 0.7,
        name: 'Male',
        dataSource: maleData,
        xValueMapper: (ChartData sales, _) => sales.xValue as num,
        yValueMapper: (ChartData sales, _) => sales.y,
        sizeValueMapper: (ChartData sales, _) => sales.size,
      ),
      BubbleSeries<ChartData, num>(
        opacity: 0.7,
        name: 'Female',
        dataSource: femaleData,
        xValueMapper: (ChartData sales, _) => sales.xValue as num,
        yValueMapper: (ChartData sales, _) => sales.y,
        sizeValueMapper: (ChartData sales, _) => sales.size,
      ),
      BubbleSeries<ChartData, num>(
        opacity: 0.7,
        name: 'Others',
        dataSource: othersData,
        xValueMapper: (ChartData sales, _) => sales.xValue as num,
        yValueMapper: (ChartData sales, _) => sales.y,
        sizeValueMapper: (ChartData sales, _) => sales.size,
      ),
    ];
  }

  void populateGenderData(SubmitQuestionerResponse data) {
    if (data.gender == 'Male') {
      maleData.add(
        ChartData(
          x: data.status,
          y: data.age.toDouble(),
          size: data.score.toDouble(),
          xValue: data.score.toDouble(),
          content: data,
        ),
      );
    } else if (data.gender == 'Female') {
      femaleData.add(
        ChartData(
          x: data.status,
          y: data.age.toDouble(),
          size: data.score.toDouble(),
          xValue: data.score.toDouble(),
          content: data,
        ),
      );
    } else {
      othersData.add(
        ChartData(
          x: data.status,
          y: data.age.toDouble(),
          size: data.score.toDouble(),
          xValue: data.score.toDouble(),
          content: data,
        ),
      );
    }
  }

  //
  @override
  void initState() {
    client.initialise();
    getChartDataDataSource = GetChartDataDataSource(client: client);
    getData();

    super.initState();
  }

  void getData() async {
    Response res = await getChartDataDataSource.dataSourceMethod();
    if (res.isSuccess) {
      chartData = res.data;
      for (var data in chartData) {
        populateGenderData(data);
      }
      addGenderDataToList();
      setState(() {
        isLoading = false;
      });
    } else {
      Fluttertoast.showToast(
        msg: res.errorMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.sp,
      );
    }
  }

  void _onbackPress() {
    CustomNavigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(right: 24.w),
          child: Column(
            children: [
              CustomSpacers.height24,
              Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: GestureDetector(
                  onTap: () {
                    _onbackPress();
                  },
                  child: Row(
                    children: [
                      ImageIconView(
                        assetPath: AppImages.ICON_BACK,
                        iconColor: AppColors.BLACK,
                        dHeight: 12.h,
                        dWidth: 16.w,
                      ),
                      CustomSpacers.width2,
                      Text(
                        "Back",
                        style: AppStyles.s16_w500_black,
                      )
                    ],
                  ),
                ),
              ),
              CustomSpacers.height32,
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                Column(
                  children: [
                    SizedBox(
                      height: 350.h,
                      child: Center(
                        child: CustomBubbleChart(
                          isCardView: false,
                          title: 'Gender based analysis',
                          primaryXAxisTitle: 'Depression Score',
                          primaryYAxisTitle: 'Age',
                          multipleBubbleSeries: genderBubbleSeries,
                        ),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    ));
  }
}

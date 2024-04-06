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
  TooltipBehavior? tooltipBehavior;

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

  //----- Marital Status Data
  List<BubbleSeries<ChartData, num>> maritalBubbleSeries = [];

  List<ChartData> mariedData = [];
  List<ChartData> unMariedData = [];
  List<ChartData> divorcedData = [];
  List<ChartData> widowedData = [];

  void addMaritalDataToList() {
    maritalBubbleSeries = [
      BubbleSeries<ChartData, num>(
        opacity: 0.7,
        name: 'Married',
        dataSource: mariedData,
        xValueMapper: (ChartData sales, _) => sales.xValue as num,
        yValueMapper: (ChartData sales, _) => sales.y,
        sizeValueMapper: (ChartData sales, _) => sales.size,
      ),
      BubbleSeries<ChartData, num>(
        opacity: 0.7,
        name: 'Unmarried',
        dataSource: unMariedData,
        xValueMapper: (ChartData sales, _) => sales.xValue as num,
        yValueMapper: (ChartData sales, _) => sales.y,
        sizeValueMapper: (ChartData sales, _) => sales.size,
      ),
      BubbleSeries<ChartData, num>(
        opacity: 0.7,
        name: 'Divorced',
        dataSource: divorcedData,
        xValueMapper: (ChartData sales, _) => sales.xValue as num,
        yValueMapper: (ChartData sales, _) => sales.y,
        sizeValueMapper: (ChartData sales, _) => sales.size,
      ),
      BubbleSeries<ChartData, num>(
        opacity: 0.7,
        name: 'Widowed',
        dataSource: widowedData,
        xValueMapper: (ChartData sales, _) => sales.xValue as num,
        yValueMapper: (ChartData sales, _) => sales.y,
        sizeValueMapper: (ChartData sales, _) => sales.size,
      ),
    ];
  }

  void populateMaritalData(SubmitQuestionerResponse data) {
    if (data.maritalStatus == 'Married') {
      mariedData.add(
        ChartData(
          x: data.status,
          y: data.age.toDouble(),
          size: data.score.toDouble(),
          xValue: data.score.toDouble(),
          content: data,
        ),
      );
    } else if (data.maritalStatus == 'Unmarried') {
      unMariedData.add(
        ChartData(
          x: data.status,
          y: data.age.toDouble(),
          size: data.score.toDouble(),
          xValue: data.score.toDouble(),
          content: data,
        ),
      );
    } else if (data.maritalStatus == 'Divorced') {
      divorcedData.add(
        ChartData(
          x: data.status,
          y: data.age.toDouble(),
          size: data.score.toDouble(),
          xValue: data.score.toDouble(),
          content: data,
        ),
      );
    } else {
      widowedData.add(
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

  //----- Employment Data
  List<BubbleSeries<ChartData, num>> emplpoymentBubbleSeries = [];

  List<ChartData> employedData = [];
  List<ChartData> unEmployedData = [];
  void addEmploymentDataToList() {
    emplpoymentBubbleSeries = [
      BubbleSeries<ChartData, num>(
        opacity: 0.7,
        name: 'Employed',
        dataSource: employedData,
        xValueMapper: (ChartData sales, _) => sales.xValue as num,
        yValueMapper: (ChartData sales, _) => sales.y,
        sizeValueMapper: (ChartData sales, _) => sales.size,
      ),
      BubbleSeries<ChartData, num>(
        opacity: 0.7,
        name: 'Unemployed',
        dataSource: unEmployedData,
        xValueMapper: (ChartData sales, _) => sales.xValue as num,
        yValueMapper: (ChartData sales, _) => sales.y,
        sizeValueMapper: (ChartData sales, _) => sales.size,
      ),
    ];
  }

  void populateEmploymentData(SubmitQuestionerResponse data) {
    if (data.employmentStatus == 'Employed') {
      employedData.add(
        ChartData(
          x: data.status,
          y: data.age.toDouble(),
          size: data.score.toDouble(),
          xValue: data.score.toDouble(),
          content: data,
        ),
      );
    } else {
      unEmployedData.add(
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
    tooltipBehavior = TooltipBehavior(
      enable: true,
      header: '',
      canShowMarker: false,
      builder: (data, point, series, pointIndex, seriesIndex) {
        data = data as ChartData;
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            'Age : ${data.content.age}\nGender : ${data.content.gender}\nMaritalStatus : ${data.content.maritalStatus}\nEmployment : ${data.content.employmentStatus}\nStatus : ${data.content.status}',
            style: AppStyles.s10_w500_white,
          ),
        );
      },
      // format: 'Age : point.y%\nGender : point.x\nStatus : point.size',
    );
    getData();

    super.initState();
  }

  void getData() async {
    Response res = await getChartDataDataSource.dataSourceMethod();
    if (res.isSuccess) {
      chartData = res.data;
      for (var data in chartData) {
        populateGenderData(data);
        populateMaritalData(data);
        populateEmploymentData(data);
      }
      addGenderDataToList();
      addMaritalDataToList();
      addEmploymentDataToList();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
        });
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
            mainAxisAlignment: isLoading ? MainAxisAlignment.center : MainAxisAlignment.start,
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
                const Center(child: CircularProgressIndicator())
              else
                Column(
                  children: [
                    SizedBox(
                      height: 350.h,
                      child: CustomBubbleChart(
                        key: GlobalKey(),
                        isCardView: false,
                        title: 'Gender based analysis',
                        primaryXAxisTitle: 'Depression Score',
                        primaryYAxisTitle: 'Age',
                        multipleBubbleSeries: genderBubbleSeries,
                        tooltipBehavior: tooltipBehavior,
                      ),
                    ),
                    CustomSpacers.height24,
                    SizedBox(
                      height: 350.h,
                      child: CustomBubbleChart(
                        key: GlobalKey(),
                        isCardView: false,
                        title: 'Marital status based analysis',
                        primaryXAxisTitle: 'Depression Score',
                        primaryYAxisTitle: 'Age',
                        multipleBubbleSeries: maritalBubbleSeries,
                        tooltipBehavior: tooltipBehavior,
                      ),
                    ),
                    CustomSpacers.height24,
                    SizedBox(
                      height: 350.h,
                      child: CustomBubbleChart(
                        key: GlobalKey(),
                        isCardView: false,
                        title: 'Employment based analysis',
                        primaryXAxisTitle: 'Depression Score',
                        primaryYAxisTitle: 'Age',
                        multipleBubbleSeries: emplpoymentBubbleSeries,
                        tooltipBehavior: tooltipBehavior,
                      ),
                    ),
                    CustomSpacers.height32,
                  ],
                )
            ],
          ),
        ),
      ),
    ));
  }
}

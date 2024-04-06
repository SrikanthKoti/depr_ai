import 'package:depr_ai/app/constants/app_colors.dart';
import 'package:depr_ai/app/constants/app_images.dart';
import 'package:depr_ai/app/constants/app_styles.dart';
import 'package:depr_ai/app/constants/custom_spacers.dart';
import 'package:depr_ai/app/custom_http_client.dart';
import 'package:depr_ai/app/router/custom_navigator.dart';
import 'package:depr_ai/data/submit_questioner_response_model.dart';
import 'package:depr_ai/datasource/get_chart_data_datasource.dart';
import 'package:depr_ai/datasource/response.dart';
import 'package:depr_ai/ui/atoms/image_icon_view.dart';
import 'package:depr_ai/ui/chart_container.dart';
import 'package:depr_ai/ui/line_chart.dart';
import 'package:depr_ai/ui/line_chart_one.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      setState(() {
        chartData = res.data;
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

  List<FlSpot> getChartData() {
    List<FlSpot> spots = [];
    for (var item in chartData) {
      double x = item.age.toDouble();
      double y = item.score.toDouble();
      spots.add(FlSpot(x, y));
    }
    return spots;
  }

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );
  // List<LineChartBarData> get lineBarsData1 => [
  //       lineChartBarData1_1,
  //       lineChartBarData1_2,
  //       lineChartBarData1_3,
  //     ];
  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        // lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );
  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return Text(value.toString(), style: style, textAlign: TextAlign.center);
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(value.toString(), style: style),
    );
  }

  FlGridData get gridData => const FlGridData(show: false);

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              CustomSpacers.height24,
              GestureDetector(
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
              CustomSpacers.height32,
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                Column(
                  children: [
                    Text(chartData.length.toString(), style: AppStyles.s64_bold_black),
                    LineChartSample1(),
                    ChartContainer(
                      title: 'Line Chart',
                      color: AppColors.C_28CBB0,
                      chart: LineChartContent(),
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

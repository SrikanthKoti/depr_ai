import 'package:depr_ai/app/constants/app_styles.dart';
import 'package:depr_ai/data/chart_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomBubbleChart extends StatefulWidget {
  final bool isCardView;
  final String title;
  final String primaryXAxisTitle;
  final String primaryYAxisTitle;
  final List<BubbleSeries<ChartData, num>> multipleBubbleSeries;
  final TooltipBehavior? tooltipBehavior;
  const CustomBubbleChart({
    super.key,
    required this.isCardView,
    required this.title,
    required this.primaryXAxisTitle,
    required this.primaryYAxisTitle,
    required this.multipleBubbleSeries,
    required this.tooltipBehavior,
  });

  @override
  State<CustomBubbleChart> createState() => _CustomBubbleChartState();
}

class _CustomBubbleChartState extends State<CustomBubbleChart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      enableAxisAnimation: true,
      enableSideBySideSeriesPlacement: true,
      zoomPanBehavior: ZoomPanBehavior(
        zoomMode: ZoomMode.xy,
        enablePinching: true,
        enableSelectionZooming: true,
        enablePanning: true,
      ),
      title: ChartTitle(
        text: widget.isCardView ? '' : "  ${widget.title}",
        alignment: ChartAlignment.near,
        textStyle: AppStyles.s16_w500_black,
      ),
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        title: AxisTitle(text: widget.isCardView ? '' : widget.primaryXAxisTitle),
        minimum: 0,
        maximum: 100,
      ),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(width: 0),
          title: AxisTitle(text: widget.isCardView ? '' : widget.primaryYAxisTitle)),
      series: widget.multipleBubbleSeries,
      legend: Legend(
          isVisible: widget.isCardView ? false : true, overflowMode: LegendItemOverflowMode.wrap),
      tooltipBehavior: widget.tooltipBehavior,
    );
  }
}

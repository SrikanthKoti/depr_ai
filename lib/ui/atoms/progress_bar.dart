import 'package:depr_ai/app/constants/app_colors.dart';
import 'package:depr_ai/app/constants/custom_spacers.dart';
import 'package:flutter/material.dart';

enum ProgressBarSizes { Default, small }

enum ProgressBarStyles { rounded, soft, sharp }

class ProgressBar extends StatefulWidget {
  final ProgressBarSizes progressBarSize;
  final ProgressBarStyles progressBarStyle;
  final double? dValue;
  final Color bgColor;
  final Color color;
  final bool bShowLabel;
  final String? strLabelText;
  final double? dHeight;
  final double? dBorderRadius;
  final TextStyle? labelTextStyle;
  final bool showLabelToTheRight;
  final double labelRightMargin;
  final double progressBarRightMargin;
  final double progressBarLeftMargin;
  final PaintingStyle progressPaintStyle;
  final double? progressStrokeWidth;

  const ProgressBar(
      {Key? key,
      this.progressBarSize = ProgressBarSizes.Default,
      this.progressBarStyle = ProgressBarStyles.rounded,
      this.dValue,
      this.bgColor = AppColors.WHITE,
      this.color = AppColors.PROGRESS_BAR_COLOR,
      this.bShowLabel = false,
      this.strLabelText,
      this.dHeight,
      this.dBorderRadius,
      this.labelTextStyle,
      this.showLabelToTheRight = false,
      this.labelRightMargin = 12,
      this.progressBarRightMargin = 16,
      this.progressBarLeftMargin = 16,
      this.progressStrokeWidth,
      this.progressPaintStyle = PaintingStyle.stroke})
      : super(key: key);

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  double _mapProgressBarSizes(ProgressBarSizes size) {
    if (size == ProgressBarSizes.small) {
      return 8.0;
    } else {
      return 16.0;
    }
  }

  double _mapProgressBarRadiusSizes(ProgressBarStyles size) {
    if (size == ProgressBarStyles.soft) {
      return 1.0;
    }
    if (size == ProgressBarStyles.sharp) {
      return 0.0;
    } else {
      return 8.0;
    }
  }

  double _mapProgressBarStylesBorderRadius(ProgressBarStyles style) {
    if (style == ProgressBarStyles.sharp) {
      return 0.0;
    } else if (style == ProgressBarStyles.soft) {
      return 4.0;
    } else {
      return 100.0;
    }
  }

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));

    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      value: "PROGRESS_BAR",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.bShowLabel)
            Container(
              margin: widget.progressBarSize == ProgressBarSizes.Default
                  ? const EdgeInsets.only(left: 8, right: 8, bottom: 9)
                  : EdgeInsets.only(left: 12, right: widget.labelRightMargin, bottom: 9),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      !widget.showLabelToTheRight ? widget.strLabelText ?? "" : "",
                      // style: widget.labelTextStyle ?? AppStyles.progressBarLabelTextStyle,
                    ),
                  ),
                  Text(
                    widget.showLabelToTheRight
                        ? widget.strLabelText ?? ""
                        : "${(widget.dValue ?? 0) * 100}%",
                    // style: widget.labelTextStyle ?? AppStyles.progressBarLabelTextStyle,
                  )
                ],
              ),
            ),
          if (widget.bShowLabel && widget.progressBarSize == ProgressBarSizes.Default)
            CustomSpacers.height8,
          Container(
            margin: EdgeInsets.only(
                left: widget.progressBarLeftMargin, right: widget.progressBarRightMargin),
            child: CustomPaint(
                painter: CustomLinearProgress((widget.dValue ?? 0) * 100,
                    //  widget.dValue! * _animationController.value,
                    progressStrokeWidth: widget.progressStrokeWidth,
                    progressPaintStyle: widget.progressPaintStyle,
                    strokeWidth: widget.dHeight ?? _mapProgressBarSizes(widget.progressBarSize),
                    borderRadius:
                        widget.dBorderRadius ?? _mapProgressBarRadiusSizes(widget.progressBarStyle),
                    progressBarStyles: widget.progressBarStyle,
                    progressColor: widget.color,
                    backgroundColor: widget.bgColor),
                child: Container(
                  alignment: Alignment.center,
                  height: widget.dHeight ?? _mapProgressBarSizes(widget.progressBarSize),
                )),
          ),
        ],
      ),
    );
  }
}

class CustomLinearProgress extends CustomPainter {
  double progress;
  double? borderRadius;
  double? strokeWidth;
  double? progressStrokeWidth;
  Color progressColor;
  Color backgroundColor;
  ProgressBarStyles progressBarStyles;
  PaintingStyle progressPaintStyle;

  CustomLinearProgress(
    this.progress, {
    this.borderRadius,
    this.strokeWidth,
    this.progressColor = AppColors.PROGRESS_BAR_COLOR,
    this.backgroundColor = AppColors.WHITE,
    this.progressBarStyles = ProgressBarStyles.rounded,
    this.progressPaintStyle = PaintingStyle.stroke,
    this.progressStrokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth!
      ..strokeCap = selectedProBarStyles()
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, strokeWidth!),
        Radius.circular(borderRadius!),
      ),
      paint,
    );

    Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = progressStrokeWidth != null ? progressStrokeWidth! : strokeWidth!
      ..strokeCap = selectedProBarStyles()
      ..style = progressPaintStyle;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          0,
          0,
          progress / 100 * size.width,
          strokeWidth!,
        ),
        Radius.circular(borderRadius!),
      ),
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  StrokeCap selectedProBarStyles() {
    if (progressBarStyles == ProgressBarStyles.rounded) {
      return StrokeCap.round;
    }
    if (progressBarStyles == ProgressBarStyles.soft) {
      return StrokeCap.round;
    } else {
      return StrokeCap.square;
    }
  }
}

import 'package:depr_ai/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double? width;
  final double height;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerContainer(
      {Key? key,
      this.width = 100,
      this.height = 100,
      this.borderRadius,
      this.padding,
      this.margin,
      this.baseColor,
      this.highlightColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.zero,
      child: Shimmer.fromColors(
        baseColor: baseColor ?? AppColors.E0E0E0,
        highlightColor: highlightColor ?? AppColors.F5F5F5,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: AppColors.WHITE,
          ),
        ),
      ),
    );
  }
}

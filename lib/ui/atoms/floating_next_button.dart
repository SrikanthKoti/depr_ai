import 'package:depr_ai/app/constants/app_colors.dart';
import 'package:depr_ai/app/constants/app_styles.dart';
import 'package:depr_ai/app/constants/custom_spacers.dart';
import 'package:flutter/material.dart';

import '../../../../ui/atoms/image_icon_view.dart';

class FloatingNextButton extends StatelessWidget {
  const FloatingNextButton({
    super.key,
    required this.isDisabled,
    required this.onTap,
    this.btnText,
  });
  final bool isDisabled;
  final void Function()? onTap;
  final String? btnText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        width: 342,
        height: 50,
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: isDisabled ? AppColors.F6A5CA.withOpacity(0.3) : AppColors.F6A5CA,
          borderRadius: BorderRadius.circular(10),
          border: isDisabled
              ? null
              : Border.all(
                  color: AppColors.F6A5CA,
                ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                btnText ?? 'Next Question',
                style: AppStyles.s20_w500_white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

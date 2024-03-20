import 'package:depr_ai/app/constants/app_colors.dart';
import 'package:depr_ai/app/constants/app_styles.dart';
import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final String option;
  const Option({super.key, required this.onTap, required this.isSelected, required this.option});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: isSelected ? AppColors.C_28CBB0 : AppColors.DADADA),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              option,
              style: isSelected ? AppStyles.s16_w400_28CBB0 : AppStyles.s16_w400_black,
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.C3E9E4 : AppColors.WHITE,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: isSelected ? AppColors.C_28CBB0 : AppColors.DADADA,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

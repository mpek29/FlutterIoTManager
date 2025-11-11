import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';

/// Custom action button for start/stop charging
class ActionButton extends StatelessWidget {
  final bool isCharging;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.isCharging,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimens.buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cardBackground,
          foregroundColor: isCharging ? AppColors.error : AppColors.success,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
          ),
        ),
        child: SizedBox(
          width: AppDimens.buttonMinWidth,
          child: Text(
            isCharging ? AppStrings.stop : AppStrings.start,
            style: AppTextStyles.buttonText,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

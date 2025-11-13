import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_text_styles.dart';

/// Widget displaying charging status with icon and text
class ChargingStatusCard extends StatelessWidget {
  final bool isCharging;

  const ChargingStatusCard({
    super.key,
    required this.isCharging,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isCharging ? Icons.electric_car : Icons.power_off,
          size: AppDimens.iconLarge,
          color: isCharging ? AppColors.success : AppColors.textSecondary,
        ),
        const SizedBox(height: AppDimens.paddingMedium),
        Text(
          isCharging ? 'Car is charging' : 'No car connected',
          style: AppTextStyles.chargingStatus,
        ),
        const SizedBox(height: AppDimens.paddingSmall),
        SizedBox(
          height: AppDimens.statusTextHeight,
          child: Text(
            isCharging
                ? '00h 00m 01s'
                : 'Plug in the cable to start charging your car',
            style: AppTextStyles.statusSubtext,
          ),
        ),
      ],
    );
  }
}

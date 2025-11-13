import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/models/charging_mode.dart';

/// Widget for selecting charging mode (Eco, Basic, Daily Trip)
class ModeSelector extends StatelessWidget {
  final ChargingMode selectedMode;
  final ValueChanged<ChargingMode> onModeSelected;

  const ModeSelector({
    super.key,
    required this.selectedMode,
    required this.onModeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ModeButton(
            mode: ChargingMode.eco,
            icon: Icons.eco,
            color: AppColors.ecoGreen,
            description: AppStrings.ecoDescription,
            isSelected: selectedMode == ChargingMode.eco,
            onTap: () => onModeSelected(ChargingMode.eco),
          ),
          _ModeButton(
            mode: ChargingMode.basic,
            icon: Icons.bolt,
            color: AppColors.basicBlue,
            description: AppStrings.basicDescription,
            isSelected: selectedMode == ChargingMode.basic,
            onTap: () => onModeSelected(ChargingMode.basic),
          ),
        ],
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  final ChargingMode mode;
  final IconData icon;
  final Color color;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeButton({
    required this.mode,
    required this.icon,
    required this.color,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppDimens.paddingMedium),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          ),
          child: Column(
            children: [
              Text(
                mode.displayName,
                style: AppTextStyles.modeTitle.copyWith(
                  color: isSelected ? color : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimens.paddingMedium),
              Icon(
                icon,
                size: AppDimens.iconMedium,
                color: isSelected ? color : AppColors.textSecondary,
              ),
              const SizedBox(height: AppDimens.paddingMedium),
              Text(
                description,
                style: AppTextStyles.modeDescription.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

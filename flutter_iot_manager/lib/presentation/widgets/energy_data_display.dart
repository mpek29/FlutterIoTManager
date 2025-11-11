import 'package:flutter/material.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_text_styles.dart';

/// Widget displaying energy and power data
class EnergyDataDisplay extends StatelessWidget {
  const EnergyDataDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _DataColumn(
          label: 'Energy',
          value: '0,00 Wh',
        ),
        const SizedBox(width: AppDimens.paddingXLarge + 10),
        _DataColumn(
          label: 'Power',
          value: '85,4 kW',
        ),
      ],
    );
  }
}

class _DataColumn extends StatelessWidget {
  final String label;
  final String value;

  const _DataColumn({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.dataLabel.copyWith(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: AppDimens.paddingSmall),
        Text(
          value,
          style: AppTextStyles.dataValue,
        ),
      ],
    );
  }
}

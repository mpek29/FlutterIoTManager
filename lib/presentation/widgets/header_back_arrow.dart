import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

/// Reusable header with back arrow
class HeaderBackArrow extends StatelessWidget {
  const HeaderBackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundLight,
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
        padding: const EdgeInsets.only(
          left: AppDimens.paddingLarge,
          right: AppDimens.paddingLarge,
          top: 35,
          bottom: 0,
        ),
        constraints: const BoxConstraints(),
        iconSize: 25,
        color: Colors.black,
      ),
    );
  }
}

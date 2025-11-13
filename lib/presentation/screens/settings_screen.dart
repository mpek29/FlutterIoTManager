import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'settings/charging_configuration_screen.dart';
import 'settings/security_screen.dart';
import 'settings/connection_screen.dart';
import 'settings/general_screen.dart';
import 'settings/about_screen.dart';

/// Settings screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimens.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Text(
                  AppStrings.settings,
                  style: AppTextStyles.pageTitle,
                ),
                const SizedBox(height: 30),
                // Settings menu items in one big card
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
                  ),
                  child: Column(
                    children: [
                      _SettingsMenuItem(
                        icon: Icons.settings,
                        iconColor: const Color(0xFF016DB6),
                        title: 'Charging Configuration',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChargingConfigurationScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, thickness: 1),
                      _SettingsMenuItem(
                        icon: Icons.security,
                        iconColor: const Color(0xFFFF9800),
                        title: 'Security',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SecurityScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, thickness: 1),
                      _SettingsMenuItem(
                        icon: Icons.wifi,
                        iconColor: const Color(0xFF4CAF50),
                        title: 'Connection',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConnectionScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, thickness: 1),
                      _SettingsMenuItem(
                        icon: Icons.tune,
                        iconColor: const Color(0xFF9C27B0),
                        title: 'General',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GeneralScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, thickness: 1),
                      _SettingsMenuItem(
                        icon: Icons.info_outline,
                        iconColor: const Color(0xFF607D8B),
                        title: 'About',
                        isLast: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Feedback card at the bottom
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.paddingLarge,
            ),
            child: Container(
              padding: const EdgeInsets.all(AppDimens.paddingLarge),
              decoration: const BoxDecoration(
                color: Color(0xFF016DB6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppDimens.radiusLarge),
                  topRight: Radius.circular(AppDimens.radiusLarge),
                ),
              ),
              child: Row(
                children: [
                  // Light blue circle with feedback icon
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFF348AC5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.feedback_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: AppDimens.paddingMedium),
                  // Text
                  const Expanded(
                    child: Text(
                      'Help us to improve!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Share Feedback button
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Open feedback form
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF348AC5),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
                      ),
                    ),
                    child: const Text(
                      'Share Feedback',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

class _SettingsMenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;
  final bool isLast;

  const _SettingsMenuItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: isLast
          ? const BorderRadius.only(
              bottomLeft: Radius.circular(AppDimens.radiusLarge),
              bottomRight: Radius.circular(AppDimens.radiusLarge),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingLarge),
        child: Row(
          children: [
            // Icon in colored circle
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 28,
              ),
            ),
            const SizedBox(width: AppDimens.paddingMedium),
            // Title
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            // Chevron icon in light grey circle
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

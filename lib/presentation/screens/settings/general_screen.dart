import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../widgets/header_back_arrow.dart';

/// General Settings Screen
class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  String _language = 'English';
  String _units = 'Metric (kW, km)';
  bool _notifications = true;
  bool _soundEffects = true;
  String _theme = 'Light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderBackArrow(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimens.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'General',
                    style: AppTextStyles.pageTitle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Configure general app preferences',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Appearance Section
                  const Text(
                    'Appearance',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSettingCard(
                    title: 'Theme',
                    subtitle: _theme,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () => _showThemeSelector(),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSettingCard(
                    title: 'Language',
                    subtitle: _language,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () => _showLanguageSelector(),
                  ),
                  const SizedBox(height: 30),
                  
                  // Units & Format Section
                  const Text(
                    'Units & Format',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSettingCard(
                    title: 'Measurement Units',
                    subtitle: _units,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () => _showUnitsSelector(),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSettingCard(
                    title: 'Date & Time Format',
                    subtitle: '24-hour format',
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      // TODO: Navigate to date/time format settings
                    },
                  ),
                  const SizedBox(height: 30),
                  
                  // Notifications Section
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSettingCard(
                    title: 'Push Notifications',
                    subtitle: 'Receive charging status updates',
                    trailing: Switch(
                      value: _notifications,
                      onChanged: (value) {
                        setState(() {
                          _notifications = value;
                        });
                      },
                      activeColor: const Color(0xFF016DB6),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSettingCard(
                    title: 'Sound Effects',
                    subtitle: 'Play sounds for app actions',
                    trailing: Switch(
                      value: _soundEffects,
                      onChanged: (value) {
                        setState(() {
                          _soundEffects = value;
                        });
                      },
                      activeColor: const Color(0xFF016DB6),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Data Management Section
                  const Text(
                    'Data Management',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSettingCard(
                    title: 'Clear Cache',
                    subtitle: 'Free up storage space',
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () => _showClearCacheDialog(),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSettingCard(
                    title: 'Export Data',
                    subtitle: 'Export charging data and settings',
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      // TODO: Export data functionality
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard({
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
      child: Container(
        padding: const EdgeInsets.all(AppDimens.paddingLarge),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  void _showThemeSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Theme',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRadioOption('Light', _theme, (value) {
              setState(() => _theme = value);
              Navigator.pop(context);
            }),
            _buildRadioOption('Dark', _theme, (value) {
              setState(() => _theme = value);
              Navigator.pop(context);
            }),
            _buildRadioOption('Auto', _theme, (value) {
              setState(() => _theme = value);
              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }

  void _showLanguageSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Language',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRadioOption('English', _language, (value) {
              setState(() => _language = value);
              Navigator.pop(context);
            }),
            _buildRadioOption('Deutsch', _language, (value) {
              setState(() => _language = value);
              Navigator.pop(context);
            }),
            _buildRadioOption('Français', _language, (value) {
              setState(() => _language = value);
              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }

  void _showUnitsSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Measurement Units',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRadioOption('Metric (kW, km)', _units, (value) {
              setState(() => _units = value);
              Navigator.pop(context);
            }),
            _buildRadioOption('Imperial (miles, kW)', _units, (value) {
              setState(() => _units = value);
              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String value, String groupValue, Function(String) onChanged) {
    return RadioListTile<String>(
      title: Text(value),
      value: value,
      groupValue: groupValue,
      onChanged: (val) => onChanged(val!),
      activeColor: const Color(0xFF016DB6),
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Clear Cache',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'This will clear all cached data. Are you sure you want to continue?',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF016DB6),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cache cleared successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Clear',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

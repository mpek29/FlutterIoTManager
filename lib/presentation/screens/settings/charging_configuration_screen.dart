import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../widgets/header_back_arrow.dart';

/// Charging Configuration Settings Screen
class ChargingConfigurationScreen extends StatefulWidget {
  const ChargingConfigurationScreen({super.key});

  @override
  State<ChargingConfigurationScreen> createState() => _ChargingConfigurationScreenState();
}

class _ChargingConfigurationScreenState extends State<ChargingConfigurationScreen> {
  bool _autoStartCharging = true;
  bool _scheduleCharging = false;
  String _defaultMode = 'Basic';
  double _maxChargingPower = 11.0;

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
                    'Charging Configuration',
                    style: AppTextStyles.pageTitle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Configure default charging behavior and preferences',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Auto Start Charging
                  _buildSettingCard(
                    title: 'Auto Start Charging',
                    subtitle: 'Automatically start charging when cable is connected',
                    trailing: Switch(
                      value: _autoStartCharging,
                      onChanged: (value) {
                        setState(() {
                          _autoStartCharging = value;
                        });
                      },
                      activeColor: const Color(0xFF016DB6),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Schedule Charging
                  _buildSettingCard(
                    title: 'Schedule Charging',
                    subtitle: 'Enable time-based charging schedules',
                    trailing: Switch(
                      value: _scheduleCharging,
                      onChanged: (value) {
                        setState(() {
                          _scheduleCharging = value;
                        });
                      },
                      activeColor: const Color(0xFF016DB6),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Default Charging Mode
                  _buildSettingCard(
                    title: 'Default Charging Mode',
                    subtitle: _defaultMode,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () => _showModeSelector(),
                  ),
                  const SizedBox(height: 16),
                  
                  // Max Charging Power
                  _buildSettingCard(
                    title: 'Max Charging Power',
                    subtitle: '${_maxChargingPower.toStringAsFixed(1)} kW',
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () => _showPowerSelector(),
                  ),
                  const SizedBox(height: 30),
                  
                  // Advanced Settings Section
                  const Text(
                    'Advanced',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSettingCard(
                    title: 'Load Management',
                    subtitle: 'Configure dynamic load balancing',
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      // TODO: Navigate to load management
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSettingCard(
                    title: 'Charging History',
                    subtitle: 'View past charging sessions',
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      // TODO: Navigate to charging history
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

  void _showModeSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Default Charging Mode',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildModeOption('Eco'),
            _buildModeOption('Basic'),
          ],
        ),
      ),
    );
  }

  Widget _buildModeOption(String mode) {
    return RadioListTile<String>(
      title: Text(mode),
      value: mode,
      groupValue: _defaultMode,
      onChanged: (value) {
        setState(() {
          _defaultMode = value!;
        });
        Navigator.pop(context);
      },
      activeColor: const Color(0xFF016DB6),
    );
  }

  void _showPowerSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Max Charging Power',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select maximum charging power'),
            const SizedBox(height: 20),
            Slider(
              value: _maxChargingPower,
              min: 3.7,
              max: 22.0,
              divisions: 10,
              label: '${_maxChargingPower.toStringAsFixed(1)} kW',
              onChanged: (value) {
                setState(() {
                  _maxChargingPower = value;
                });
              },
              activeColor: const Color(0xFF016DB6),
            ),
            Text(
              '${_maxChargingPower.toStringAsFixed(1)} kW',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF016DB6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

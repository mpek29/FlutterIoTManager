import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../widgets/header_back_arrow.dart';

/// Connection Settings Screen
class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  String _wifiStatus = 'Connected';
  String _wifiNetwork = 'go-e-266000';
  String _signalStrength = 'Strong';
  bool _autoReconnect = true;

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
                    'Connection',
                    style: AppTextStyles.pageTitle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manage network and connectivity settings',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // WiFi Status Card
                  Container(
                    padding: const EdgeInsets.all(AppDimens.paddingLarge),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
                      border: Border.all(
                        color: const Color(0xFF4CAF50),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.wifi,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: AppDimens.paddingMedium),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _wifiStatus,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4CAF50),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _wifiNetwork,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Signal: $_signalStrength',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // WiFi Settings
                  const Text(
                    'WiFi Settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSettingCard(
                    title: 'Change Network',
                    subtitle: 'Connect to a different WiFi network',
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      // TODO: Navigate to WiFi selection
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSettingCard(
                    title: 'Auto-Reconnect',
                    subtitle: 'Automatically reconnect to known networks',
                    trailing: Switch(
                      value: _autoReconnect,
                      onChanged: (value) {
                        setState(() {
                          _autoReconnect = value;
                        });
                      },
                      activeColor: const Color(0xFF016DB6),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSettingCard(
                    title: 'Network Diagnostics',
                    subtitle: 'Test connection and view network info',
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () => _showNetworkDiagnostics(),
                  ),
                  const SizedBox(height: 30),
                  
                  // Advanced Settings
                  const Text(
                    'Advanced',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSettingCard(
                    title: 'Static IP Configuration',
                    subtitle: 'Configure manual IP address',
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      // TODO: Navigate to static IP config
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSettingCard(
                    title: 'Bluetooth Settings',
                    subtitle: 'Configure Bluetooth connectivity',
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      // TODO: Navigate to Bluetooth settings
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSettingCard(
                    title: 'Cloud Sync',
                    subtitle: 'Manage cloud data synchronization',
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      // TODO: Navigate to cloud sync settings
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

  void _showNetworkDiagnostics() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Network Diagnostics',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDiagnosticRow('Network', _wifiNetwork),
            const SizedBox(height: 12),
            _buildDiagnosticRow('Status', _wifiStatus),
            const SizedBox(height: 12),
            _buildDiagnosticRow('Signal Strength', _signalStrength),
            const SizedBox(height: 12),
            _buildDiagnosticRow('IP Address', '192.168.1.100'),
            const SizedBox(height: 12),
            _buildDiagnosticRow('MAC Address', 'AA:BB:CC:DD:EE:FF'),
            const SizedBox(height: 12),
            _buildDiagnosticRow('Gateway', '192.168.1.1'),
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

  Widget _buildDiagnosticRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}

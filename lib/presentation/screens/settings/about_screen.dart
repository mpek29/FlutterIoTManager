import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../widgets/header_back_arrow.dart';
import 'details/software_details_screen.dart';
import 'details/hardware_details_screen.dart';

/// About Screen
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
                    'About',
                    style: AppTextStyles.pageTitle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'App information and legal details',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // App Logo and Version
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFF016DB6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.ev_station,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'IoT Manager',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Version 1.0.0 (Build 1)',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Software Version Section
                  const Text(
                    'Software',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildInfoCard(
                    title: 'Software Version',
                    subtitle: '1.0.0',
                    icon: Icons.settings_system_daydream,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SoftwareDetailsScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  
                  // Hardware Information Section
                  const Text(
                    'Hardware Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildInfoCard(
                    title: 'Serial Number',
                    subtitle: 'SN-WBP-2024-001',
                    icon: Icons.tag,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HardwareDetailsScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  
                  _buildInfoCard(
                    title: 'MAC Address Station',
                    subtitle: 'AA:BB:CC:DD:EE:FF',
                    icon: Icons.router,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () => _showCopyDialog(context, 'MAC Address Station', 'AA:BB:CC:DD:EE:FF'),
                  ),
                  const SizedBox(height: 12),
                  
                  _buildInfoCard(
                    title: 'MAC Address Hotspot',
                    subtitle: 'AA:BB:CC:DD:EE:00',
                    icon: Icons.wifi_tethering,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () => _showCopyDialog(context, 'MAC Address Hotspot', 'AA:BB:CC:DD:EE:00'),
                  ),
                  const SizedBox(height: 12),
                  
                  _buildInfoCard(
                    title: 'Hardware Version',
                    subtitle: 'v2.1',
                    icon: Icons.developer_board,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () => _showDetailDialog(context, 'Hardware Version', 'v2.1', 'Hardware revision of the charging station'),
                  ),
                  const SizedBox(height: 12),
                  
                  _buildInfoCard(
                    title: 'Variant',
                    subtitle: 'go-e Charger Gemini flex 11 kW',
                    icon: Icons.category,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () => _showDetailDialog(
                      context,
                      'Variant',
                      'go-e Charger Gemini flex 11 kW',
                      'Model: Gemini flex\nMax Power: 11 kW\nPhases: 3-phase capable\nType: Wallbox',
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  _buildInfoCard(
                    title: 'Default Route',
                    subtitle: '192.168.1.1',
                    icon: Icons.route,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () => _showCopyDialog(context, 'Default Route', '192.168.1.1'),
                  ),
                  const SizedBox(height: 12),
                  
                  _buildInfoCard(
                    title: 'RSSI',
                    subtitle: '-45 dBm (Excellent)',
                    icon: Icons.signal_cellular_alt,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () => _showDetailDialog(
                      context,
                      'RSSI (Signal Strength)',
                      '-45 dBm',
                      'Signal Quality: Excellent\n\nRSSI (Received Signal Strength Indicator)\n-30 to -50 dBm: Excellent\n-50 to -60 dBm: Good\n-60 to -70 dBm: Fair\n-70+ dBm: Weak',
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  _buildInfoCard(
                    title: 'Charge Controller Firmware Version',
                    subtitle: '055.1',
                    icon: Icons.memory,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () => _showDetailDialog(
                      context,
                      'Charge Controller Firmware',
                      '055.1',
                      'Current firmware version of the charge controller\n\nRelease Date: November 2024\nStatus: Up to date',
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // App Info Section
                  const Text(
                    'Application',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildInfoCard(
                    title: 'Developer',
                    subtitle: 'go-e GmbH',
                    icon: Icons.business,
                  ),
                  const SizedBox(height: 12),
                  
                  _buildInfoCard(
                    title: 'Website',
                    subtitle: 'www.go-e.com',
                    icon: Icons.language,
                    onTap: () {
                      // TODO: Open website
                    },
                  ),
                  const SizedBox(height: 12),
                  
                  _buildInfoCard(
                    title: 'Support',
                    subtitle: 'support@go-e.com',
                    icon: Icons.email,
                    onTap: () {
                      // TODO: Open email client
                    },
                  ),
                  const SizedBox(height: 30),
                  
                  // Legal Section
                  const Text(
                    'Legal',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildInfoCard(
                    title: 'Terms of Service',
                    subtitle: 'View our terms and conditions',
                    icon: Icons.description,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      // TODO: Open terms of service
                    },
                  ),
                  const SizedBox(height: 12),
                  
                  _buildInfoCard(
                    title: 'Privacy Policy',
                    subtitle: 'How we handle your data',
                    icon: Icons.privacy_tip,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      // TODO: Open privacy policy
                    },
                  ),
                  const SizedBox(height: 12),
                  
                  _buildInfoCard(
                    title: 'Open Source Licenses',
                    subtitle: 'Third-party software licenses',
                    icon: Icons.code,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      _showLicenses(context);
                    },
                  ),
                  const SizedBox(height: 30),
                  
                  // Additional Info
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '© 2025 go-e GmbH',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'All rights reserved',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String subtitle,
    required IconData icon,
    Widget? trailing,
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
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF016DB6).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: const Color(0xFF016DB6),
                size: 28,
              ),
            ),
            const SizedBox(width: AppDimens.paddingMedium),
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
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  void _showDetailDialog(BuildContext context, String title, String value, String details) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF016DB6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF016DB6),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              details,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
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

  void _showCopyDialog(BuildContext context, String title, String value) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF016DB6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF016DB6),
                  width: 2,
                ),
              ),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF016DB6),
                  fontFamily: 'monospace',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: value));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$title copied to clipboard'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF016DB6),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.copy, color: Colors.white),
                label: const Text(
                  'Copy to Clipboard',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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

  void _showLicenses(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Open Source Licenses',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildLicenseItem('Flutter', 'BSD 3-Clause License'),
              _buildLicenseItem('connectivity_plus', 'BSD 3-Clause License'),
              _buildLicenseItem('permission_handler', 'MIT License'),
              _buildLicenseItem('mobile_scanner', 'BSD 3-Clause License'),
            ],
          ),
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

  Widget _buildLicenseItem(String name, String license) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            license,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

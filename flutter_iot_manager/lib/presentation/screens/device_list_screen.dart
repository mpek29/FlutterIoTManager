import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/models/device.dart';
import '../widgets/device_card.dart';
import '../widgets/header_back_arrow.dart';

/// Screen displaying list of available devices
class DeviceListScreen extends StatelessWidget {
  const DeviceListScreen({super.key});

  // Sample devices - in a real app, this would come from a data source
  static final List<Device> _devices = [
    const Device(
      id: '1',
      name: 'wallbox-plus_266000',
      isOnline: true,
      status: AppStrings.connected,
      serialNumber: 'SN-WBP-2024-001',
    ),
    const Device(
      id: '2',
      name: 'go-eCharger_123456',
      isOnline: false,
      status: AppStrings.offline,
      serialNumber: 'SN-GEC-2024-002',
    ),
    const Device(
      id: '3',
      name: 'wallbox-home_789012',
      isOnline: true,
      status: AppStrings.connected,
      serialNumber: 'SN-WBH-2024-003',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thin header with back arrow
          const HeaderBackArrow(),
          // Main content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppDimens.paddingLarge,
                right: 20,
                bottom: 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Device List',
                    style: AppTextStyles.pageTitle,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'My Devices',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle manage action
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Manage',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.info,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _devices.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: AppDimens.radiusMedium,
                      ),
                      itemBuilder: (context, index) {
                        final device = _devices[index];
                        return DeviceCard(
                          device: device,
                          onTap: () => Navigator.pop(context, device.name),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 250,
        height: AppDimens.buttonHeight,
        margin: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton.extended(
          onPressed: () {
            // Handle add device action
          },
          backgroundColor: const Color(0xFF016DB6),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
          ),
          label: const Text(
            '+ Add or setup device',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

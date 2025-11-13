import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/models/charging_mode.dart';
import '../widgets/action_button.dart';
import '../widgets/basic_mode_settings.dart';
import '../widgets/charging_status_card.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/eco_mode_settings.dart';
import '../widgets/energy_data_display.dart';
import '../widgets/mode_selector.dart';
import 'device_list_screen.dart';
import 'settings_screen.dart';

/// Home screen displaying charging status and controls
class HomeScreen extends StatefulWidget {
  final String? initialDeviceType;
  final String? initialSerialNumber;
  
  const HomeScreen({
    super.key,
    this.initialDeviceType,
    this.initialSerialNumber,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ChargingMode _selectedMode = ChargingMode.basic;
  late String _selectedDevice;
  bool _isCharging = true;

  @override
  void initState() {
    super.initState();
    // Use the initial device if provided, otherwise use default
    if (widget.initialDeviceType != null && widget.initialSerialNumber != null) {
      _selectedDevice = '${widget.initialDeviceType}_${widget.initialSerialNumber}';
    } else {
      _selectedDevice = 'wallbox-plus_266000';
    }
  }

  void _toggleCharging() {
    setState(() {
      _isCharging = !_isCharging;
    });
  }

  void _onModeSelected(ChargingMode mode) {
    setState(() {
      _selectedMode = mode;
    });
  }

  Future<void> _navigateToDeviceList() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => const DeviceListScreen(),
      ),
    );
    
    if (result != null && mounted) {
      setState(() {
        _selectedDevice = result;
      });
    }
  }

  void _navigateToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            _navigateToSettings();
          }
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryDark,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_selectedDevice, style: AppTextStyles.headerTitle),
          InkWell(
            onTap: _navigateToDeviceList,
            child: const Text(
              AppStrings.deviceList,
              style: AppTextStyles.headerTitle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side - Status and data
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChargingStatusCard(isCharging: _isCharging),
                    const SizedBox(height: AppDimens.paddingLarge),
                    const EnergyDataDisplay(),
                  ],
                ),
              ),
            ),
            // Right side - Product image
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppDimens.paddingLarge,
                  right: AppDimens.paddingLarge,
                  top: AppDimens.paddingLarge,
                  bottom: AppDimens.paddingLarge
                  ),
                child: SizedBox(
                  height: AppDimens.productImageHeight,
                  child: Image.asset(
                    'assets/images/product.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(AppDimens.paddingLarge),
          child: ActionButton(
            isCharging: _isCharging,
            onPressed: _toggleCharging,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppDimens.paddingLarge),
          child: ModeSelector(
            selectedMode: _selectedMode,
            onModeSelected: _onModeSelected,
          ),
        ),
        // Show eco mode settings only when eco mode is selected
        if (_selectedMode == ChargingMode.eco)
          Padding(
            padding: const EdgeInsets.only(
              left: AppDimens.paddingLarge,
              right: AppDimens.paddingLarge,
              bottom: AppDimens.paddingLarge,
            ),
            child: const EcoModeSettings(),
          ),
        // Show basic mode settings only when basic mode is selected
        if (_selectedMode == ChargingMode.basic)
          Padding(
            padding: const EdgeInsets.only(
              left: AppDimens.paddingLarge,
              right: AppDimens.paddingLarge,
              bottom: AppDimens.paddingLarge,
            ),
            child: const BasicModeSettings(),
          ),
      ],
    );
  }
}

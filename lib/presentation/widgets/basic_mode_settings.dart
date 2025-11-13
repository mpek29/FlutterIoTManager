import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';

/// Widget displaying basic mode settings (Charging Speed and Energy Limit)
class BasicModeSettings extends StatefulWidget {
  const BasicModeSettings({super.key});

  @override
  State<BasicModeSettings> createState() => _BasicModeSettingsState();
}

class _BasicModeSettingsState extends State<BasicModeSettings> {
  String _chargingSpeed = '32 Ampere & Automatic phase selection';
  bool _energyLimitEnabled = false;
  String _energyLimitValue = '50 kWh';

  void _editChargingSpeed() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const _ChargingSpeedDialog(),
    );

    if (result != null) {
      setState(() {
        final ampere = result['ampere'];
        final phase = result['phase'];
        _chargingSpeed = '$ampere Ampere & $phase';
      });
    }
  }

  void _editEnergyLimit() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _EnergyLimitDialog(
        isEnabled: _energyLimitEnabled,
        currentValue: _energyLimitValue.replaceAll(' kWh', ''),
      ),
    );

    if (result != null) {
      setState(() {
        _energyLimitEnabled = result['enabled'] as bool;
        if (_energyLimitEnabled) {
          _energyLimitValue = '${result['value']} kWh';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SettingCard(
          icon: Icons.bolt,
          title: 'Charging speed',
          value: _chargingSpeed,
          onTap: _editChargingSpeed,
        ),
        const SizedBox(height: AppDimens.paddingLarge),
        _SettingCard(
          icon: Icons.battery_charging_full,
          title: 'Energy Limit',
          value: _energyLimitEnabled ? _energyLimitValue : 'Off',
          onTap: _editEnergyLimit,
        ),
      ],
    );
  }
}

class _SettingCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _SettingCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
            // Black circle with white icon
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: AppDimens.paddingMedium),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
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

class _ChargingSpeedDialog extends StatefulWidget {
  const _ChargingSpeedDialog();

  @override
  State<_ChargingSpeedDialog> createState() => _ChargingSpeedDialogState();
}

class _ChargingSpeedDialogState extends State<_ChargingSpeedDialog> {
  String _ampere = '32';
  String _phaseSelection = 'Automatic phase selection';

  final List<String> _ampereOptions = ['6', '8', '10', '13', '16', '20', '25', '32'];
  final List<String> _phaseOptions = [
    'Automatic phase selection',
    '1 phase',
    '3 phases',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Charging Speed',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Configure the charging speed for your device',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Ampere',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonFormField<String>(
                value: _ampere,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                items: _ampereOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      '$value A',
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _ampere = newValue;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Phase Selection',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonFormField<String>(
                value: _phaseSelection,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                items: _phaseOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _phaseSelection = newValue;
                    });
                  }
                },
              ),
            ),
          ],
        ),
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
                  Navigator.pop(context, {
                    'ampere': _ampere,
                    'phase': _phaseSelection,
                  });
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF016DB6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _EnergyLimitDialog extends StatefulWidget {
  final bool isEnabled;
  final String currentValue;

  const _EnergyLimitDialog({
    required this.isEnabled,
    required this.currentValue,
  });

  @override
  State<_EnergyLimitDialog> createState() => _EnergyLimitDialogState();
}

class _EnergyLimitDialogState extends State<_EnergyLimitDialog> {
  late bool _isEnabled;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _isEnabled = widget.isEnabled;
    _controller = TextEditingController(text: widget.currentValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Energy Limit',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Set a maximum energy limit for this charging session',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Enable Energy Limit',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Switch(
                value: _isEnabled,
                onChanged: (value) {
                  setState(() {
                    _isEnabled = value;
                  });
                },
                activeColor: const Color(0xFF016DB6),
              ),
            ],
          ),
          if (_isEnabled) ...[
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Energy Limit (kWh)',
                hintText: 'Enter energy limit',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ],
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
                  Navigator.pop(context, {
                    'enabled': _isEnabled,
                    'value': _controller.text,
                  });
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF016DB6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

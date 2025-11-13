import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../widgets/header_back_arrow.dart';

/// Screen for adding device details based on device type
class AddDeviceDetailsScreen extends StatefulWidget {
  final String deviceType;

  const AddDeviceDetailsScreen({
    super.key,
    required this.deviceType,
  });

  @override
  State<AddDeviceDetailsScreen> createState() => _AddDeviceDetailsScreenState();
}

class _AddDeviceDetailsScreenState extends State<AddDeviceDetailsScreen> {
  bool _obscurePassword = true;
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _serialNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String get _title {
    switch (widget.deviceType) {
      case 'AC Wallbox':
        return 'Add AC Wallbox';
      case 'DC Wallbox':
        return 'Add DC Wallbox';
      case 'SmartMeter':
        return 'Add SmartMeter';
      default:
        return 'Add Device';
    }
  }

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
                right: AppDimens.paddingLarge,
                bottom: AppDimens.paddingLarge,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _title,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // TODO: Add device-specific content here
                  Text(
                    'Enter ${widget.deviceType} serial number and password',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'The serial number is on ${widget.deviceType} reset card and password usually was set during the setup process.',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  const SizedBox(height: 8),
                  TextField(
                    controller: _serialNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      hintText: '${widget.deviceType} Serial number',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: '${widget.deviceType} password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey[600],
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

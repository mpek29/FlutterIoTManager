import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../widgets/header_back_arrow.dart';
import 'setup_device_screen.dart';
import 'add_device_screen.dart';

/// Welcome screen shown when no devices are added yet
class WelcomeScreen extends StatelessWidget {
  final bool showBackArrow;
  
  const WelcomeScreen({
    super.key,
    this.showBackArrow = false, // Par défaut, pas de flèche
  });

  void _showTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Terms & Conditions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Before start to setup go-e device you must accept the Terms & Conditions.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Hold on! If you\'re not an electrician, it\'s recommended not to continue.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF016DB6),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigate to setup device screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SetupDeviceScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Agree',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF016DB6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thin header with back arrow (only if showBackArrow is true)
          if (showBackArrow) const HeaderBackArrow(),
          // Main content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingLarge),
                    child: Text(
                      'Add or setup device',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                // Icon or illustration
                Padding(
                  padding: const EdgeInsets.all(AppDimens.paddingLarge),
                  child: Icon(
                    Icons.devices_other,
                    size: 120,
                    color: Colors.grey[400],
                  ),
                ),
                  
                const Spacer(),
                // Initial setup description
                Padding(
                  padding: const EdgeInsets.all(AppDimens.paddingLarge),
                  child: Column(
                    children: [
                      Text(
                        'Initial setup for new devices (electricians use this)',
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      // Add device button
                      SizedBox(
                        width: double.infinity,
                        height: AppDimens.buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {
                            _showTermsAndConditions(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF016DB6),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
                            ),
                          ),
                          child: const Text(
                            'Set up a device',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Or text
                      Text(
                        'or',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      // Second button (same as first)
                      Text(
                        'Add an already setup device',
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: AppDimens.buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to add device screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddDeviceScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xE0E0E2E2),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
                            ),
                          ),
                          child: const Text(
                            'Add a device',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color:  Color(0xFF016DB6),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

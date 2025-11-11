import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../widgets/header_back_arrow.dart';
import 'qr_scanner_screen.dart';

/// Screen for setting up a new device
class SetupDeviceScreen extends StatelessWidget {
  const SetupDeviceScreen({super.key});

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
                  const Text(
                    'Setup new device',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Scan the QR code from the reset card or data card to connect your phone to the device.',
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Image placeholder and description
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image with controlled width (maintains aspect ratio)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
                          child: Image.asset(
                            'assets/images/reset_pic.png',
                            width: 200,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Description text
                        Text(
                          'All device have a QR code. You can find the QR code on the reset card.',
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // First button
                  SizedBox(
                    width: double.infinity,
                    height: AppDimens.buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to QR scanner screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QRScannerScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF016DB6),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
                        ),
                      ),
                      child: const Text(
                        'Scan QR Code',
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
                  Center(
                    child: Text(
                      'or',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Description for manual connection
                  Center(
                    child: Text(
                      'Can\'t scan QR code? Try to connect manually',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Second button
                  SizedBox(
                    width: double.infinity,
                    height: AppDimens.buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle second button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xE0E0E2E2),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
                        ),
                      ),
                      child: const Text(
                        'Connect manually',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF016DB6),
                        ),
                      ),
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
}

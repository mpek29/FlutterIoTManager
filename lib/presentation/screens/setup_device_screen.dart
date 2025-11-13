import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../widgets/header_back_arrow.dart';
import 'qr_scanner_screen.dart';

/// Screen for setting up a new device
class SetupDeviceScreen extends StatelessWidget {
  const SetupDeviceScreen({super.key});

  static const platform = MethodChannel('com.example.flutteriotmanager/wifi');

  Future<void> _openWifiSettings() async {
    try {
      await platform.invokeMethod('openWifiSettings');
    } on PlatformException catch (e) {
      print("Failed to open WiFi settings: '${e.message}'.");
    }
  }

  Future<void> _connectToWifi(String ssid, String password, BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20),
                Expanded(
                  child: Text('Connecting to $ssid...'),
                ),
              ],
            ),
          ),
        );
      },
    );

    try {
      final result = await platform.invokeMethod('connectToWifi', {
        'ssid': ssid,
        'password': password,
      });
      
      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.toString()),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      
      print('WiFi connection result: $result');
    } on PlatformException catch (e) {
      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
        
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Connection failed: ${e.message}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
      
      print("Failed to connect to WiFi: '${e.message}'.");
    }
  }

  Map<String, String>? _parseQRData(String qrData) {
    try {
      print('Parsing QR data: $qrData');
      
      // Check if it's WiFi QR code format: WIFI:T:WPA;S:ssid;P:password;;
      if (qrData.toUpperCase().startsWith('WIFI:')) {
        String? ssid;
        String? password;
        String? securityType;
        
        // Split by semicolon
        final parts = qrData.split(';');
        
        for (var part in parts) {
          part = part.trim();
          if (part.startsWith('T:')) {
            securityType = part.substring(2); // Remove 'T:'
          } else if (part.startsWith('S:')) {
            ssid = part.substring(2); // Remove 'S:'
          } else if (part.startsWith('P:')) {
            password = part.substring(2); // Remove 'P:'
          }
        }
        
        print('Extracted - Security: $securityType, SSID: $ssid, Password: $password');
        
        if (ssid != null && password != null) {
          final result = {'ssid': ssid, 'password': password};
          if (securityType != null) {
            result['security'] = securityType;
          }
          return result;
        }
      }
      
      // Fallback to old parsing method for different formats
      final data = qrData.split('\n');
      String? ssid;
      String? password;
      
      for (var line in data) {
        if (line.toLowerCase().contains('ssid') || line.toLowerCase().contains('hotspot ssid')) {
          ssid = line.split(':').last.trim();
        } else if (line.toLowerCase().contains('key') || line.toLowerCase().contains('password') || line.toLowerCase().contains('hotspot key')) {
          password = line.split(':').last.trim();
        }
      }
      
      if (ssid != null && password != null) {
        return {'ssid': ssid, 'password': password};
      }
    } catch (e) {
      print('Error parsing QR data: $e');
    }
    return null;
  }

  Future<void> _checkWifiAndNavigate(BuildContext context) async {
    try {
      // Just navigate directly to QR scanner
      // WiFi check is not reliable when WiFi is on but not connected
      print('Navigating to QR scanner');
      final qrCodeData = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (context) => const QRScannerScreen(),
        ),
      );
        
      // Handle the scanned QR code data
      if (qrCodeData != null && context.mounted) {
        print('QR Code scanned: $qrCodeData');
        print('Context is mounted: ${context.mounted}');
        
        // Parse QR data to extract SSID and password
        final wifiCredentials = _parseQRData(qrCodeData);
        print('Parsed WiFi credentials: $wifiCredentials');
        
        if (wifiCredentials != null) {
          // Show dialog with WiFi info and connect
          print('Showing WiFi connection dialog...');
          _showWifiConnectionDialog(
            context, 
            wifiCredentials['ssid']!, 
            wifiCredentials['password']!, 
            wifiCredentials['security'],
            qrCodeData,
          );
        } else {
          // If no WiFi credentials found, just show the data
          print('No WiFi credentials found, showing raw QR data...');
          _showQRCodeDataDialog(context, qrCodeData);
        }
      } else {
        print('QR Code data is null or context not mounted');
        print('qrCodeData: $qrCodeData');
        print('context.mounted: ${context.mounted}');
      }
    } catch (e) {
      print('Error navigating to scanner: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening scanner: $e')),
        );
      }
    }
  }

  void _showWifiConnectionDialog(BuildContext context, String ssid, String password, String? securityType, String fullQrData) {
    print('_showWifiConnectionDialog called');
    print('SSID: $ssid, Password: $password, Security: $securityType');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        print('WiFi connection dialog builder called');
        return WillPopScope(
          onWillPop: () async {
            print('WillPopScope triggered - someone trying to close dialog');
            return false; // Prevent back button from closing
          },
          child: AlertDialog(
            title: const Text(
              'WiFi Hotspot Detected',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Device hotspot credentials found:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SSID: $ssid',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Password: $password',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        if (securityType != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Security: $securityType',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Do you want to connect to this WiFi hotspot?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
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
                      onPressed: () {
                        print('Cancel button pressed in WiFi dialog');
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
                      onPressed: () async {
                        print('Connect button pressed in WiFi dialog');
                        Navigator.of(context).pop();
                        // Connect to WiFi
                        print('Attempting to connect to WiFi: $ssid');
                        await _connectToWifi(ssid, password, context);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Connect',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF016DB6),
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
      },
    ).then((value) {
      print('WiFi connection dialog closed');
    });
  }

  void _showQRCodeDataDialog(BuildContext context, String qrData) {
    print('_showQRCodeDataDialog called');
    print('QR Data length: ${qrData.length} characters');
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        print('QR Code data dialog builder called');
        return WillPopScope(
          onWillPop: () async {
            print('WillPopScope triggered in QR data dialog');
            return false; // Prevent back button from closing
          },
          child: AlertDialog(
            title: const Text(
              'QR Code Scanned',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Scanned Data:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      qrData,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  print('OK button pressed in QR data dialog');
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF016DB6),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ).then((value) {
      print('QR Code data dialog closed');
    });
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
                        _checkWifiAndNavigate(context);
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

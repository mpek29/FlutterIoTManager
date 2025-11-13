import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../widgets/header_back_arrow.dart';
import 'setup_complete_screen.dart';

/// Screen for setting up network connection
class NetworkSetupScreen extends StatefulWidget {
  final String deviceType;
  final String? serialNumber;
  
  const NetworkSetupScreen({
    super.key,
    required this.deviceType,
    this.serialNumber,
  });

  @override
  State<NetworkSetupScreen> createState() => _NetworkSetupScreenState();
}

class _NetworkSetupScreenState extends State<NetworkSetupScreen> {
  List<WifiNetwork> availableNetworks = [];
  String? selectedNetworkSsid;
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    _scanWifiNetworks();
  }

  Future<void> _scanWifiNetworks() async {
    setState(() {
      isScanning = true;
    });

    // Simulate WiFi scanning - Replace this with actual WiFi scanning logic
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      availableNetworks = [
        WifiNetwork(ssid: 'Home WiFi', signalStrength: 4, isSecured: true),
        WifiNetwork(ssid: 'Office Network', signalStrength: 3, isSecured: true),
        WifiNetwork(ssid: 'Guest WiFi', signalStrength: 2, isSecured: false),
        WifiNetwork(ssid: 'Mobile Hotspot', signalStrength: 1, isSecured: true),
      ];
      isScanning = false;
    });
  }

  void _showPasswordDialog(String ssid) {
    final TextEditingController passwordController = TextEditingController();
    bool obscurePassword = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                'Connect to $ssid',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setDialogState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle WiFi connection with password
                    Navigator.of(context).pop();
                    _connectToNetwork(ssid, passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF016DB6),
                  ),
                  child: const Text(
                    'Connect',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _connectToNetwork(String ssid, String password) {
    // TODO: Implement actual WiFi connection logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Connecting to $ssid...'),
        duration: const Duration(seconds: 2),
      ),
    );
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
                    'Setup',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Steps with bubbles
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStep(1, 'Charger', isCompleted: true, isCurrent: false),
                        _buildStep(2, 'Grid', isCompleted: true, isCurrent: false),
                        _buildStep(3, 'Network', isCompleted: false, isCurrent: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Choose a network',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Choose a Wi-Fi network to connect your ${widget.deviceType} to the network',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // WiFi network header with Scan button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Wi-Fi network',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: isScanning ? null : _scanWifiNetworks,
                        icon: Icon(
                          Icons.refresh,
                          color: isScanning ? Colors.grey : const Color(0xFF016DB6),
                        ),
                        label: Text(
                          'Scan',
                          style: TextStyle(
                            fontSize: 16,
                            color: isScanning ? Colors.grey : const Color(0xFF016DB6),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // WiFi networks list
                  Expanded(
                    child: isScanning
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 16),
                                Text('Scanning for networks...'),
                              ],
                            ),
                          )
                        : availableNetworks.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.wifi_off,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'No networks found',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextButton(
                                      onPressed: _scanWifiNetworks,
                                      child: const Text('Scan again'),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: availableNetworks.length,
                                itemBuilder: (context, index) {
                                  final network = availableNetworks[index];
                                  final isSelected = network.ssid == selectedNetworkSsid;
                                  
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF016DB6)
                                            : Colors.grey[300]!,
                                        width: isSelected ? 2 : 1,
                                      ),
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        if (isSelected) {
                                          // Unselect if already selected
                                          setState(() {
                                            selectedNetworkSsid = null;
                                          });
                                        } else {
                                          // Select and show password dialog if secured
                                          setState(() {
                                            selectedNetworkSsid = network.ssid;
                                          });
                                          if (network.isSecured) {
                                            _showPasswordDialog(network.ssid);
                                          } else {
                                            _connectToNetwork(network.ssid, '');
                                          }
                                        }
                                      },
                                      leading: Icon(
                                        network.isSecured ? Icons.lock : Icons.wifi,
                                        color: isSelected
                                            ? const Color(0xFF016DB6)
                                            : Colors.grey[600],
                                      ),
                                      title: Text(
                                        network.ssid,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            _getSignalIcon(network.signalStrength),
                                            color: _getSignalColor(network.signalStrength),
                                          ),
                                          if (isSelected) ...[
                                            const SizedBox(width: 8),
                                            const Icon(
                                              Icons.check_circle,
                                              color: Color(0xFF016DB6),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ),
                  const SizedBox(height: 20),
                  // Skip/Continue button at bottom
                  Center(
                    child: selectedNetworkSsid != null
                        ? SizedBox(
                            width: double.infinity,
                            height: AppDimens.buttonHeight,
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to setup complete screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SetupCompleteScreen(
                                      deviceType: widget.deviceType,
                                      serialNumber: widget.serialNumber,
                                    ),
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
                                'Continue',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : TextButton(
                            onPressed: () {
                              // Navigate to setup complete screen without network selection
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SetupCompleteScreen(
                                    deviceType: widget.deviceType,
                                    serialNumber: widget.serialNumber,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Skip',
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

  Widget _buildStep(int number, String label, {required bool isCompleted, required bool isCurrent}) {
    return Column(
      children: [
        // Bubble
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted
                ? Colors.green
                : isCurrent
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : Colors.grey[300],
            border: isCurrent ? Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 3) : null,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 15)
                : Text(
                    '$number',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isCurrent ? Colors.white : Colors.grey[600],
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 12),
        // Label
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  IconData _getSignalIcon(int strength) {
    switch (strength) {
      case 4:
        return Icons.signal_wifi_4_bar;
      case 3:
        return Icons.signal_wifi_4_bar;
      case 2:
        return Icons.signal_wifi_4_bar;
      case 1:
        return Icons.signal_wifi_4_bar;
      default:
        return Icons.signal_wifi_0_bar;
    }
  }

  Color _getSignalColor(int strength) {
    switch (strength) {
      case 4:
        return Colors.green;
      case 3:
        return Colors.lightGreen;
      case 2:
        return Colors.orange;
      case 1:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

// Model class for WiFi networks
class WifiNetwork {
  final String ssid;
  final int signalStrength; // 1-4
  final bool isSecured;

  WifiNetwork({
    required this.ssid,
    required this.signalStrength,
    required this.isSecured,
  });
}

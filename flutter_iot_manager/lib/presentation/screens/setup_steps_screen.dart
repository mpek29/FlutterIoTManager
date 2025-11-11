import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../widgets/header_back_arrow.dart';
import 'qr_scanner_screen.dart';

/// Screen for setting up a new device
class SetupStepsScreen extends StatefulWidget {
  const SetupStepsScreen({super.key});

  @override
  State<SetupStepsScreen> createState() => _SetupStepsScreenState();
}

class _SetupStepsScreenState extends State<SetupStepsScreen> {
  String selectedCountry = 'Germany (16A)';
  
  final List<String> countries = [
    'Germany (16A)',
    'France (16A)',
    'UK (13A)',
    'USA (15A)',
    'Spain (16A)',
    'Italy (16A)',
  ];

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: ListView.builder(
            itemCount: countries.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(countries[index]),
                trailing: countries[index] == selectedCountry
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  setState(() {
                    selectedCountry = countries[index];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
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
                        _buildStep(2, 'Grid', isCompleted: false, isCurrent: true),
                        _buildStep(3, 'Network', isCompleted: false, isCurrent: false),
                        _buildStep(4, 'Security', isCompleted: false, isCurrent: false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Set grid configurations',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Select a country to pre-configure the appropriate grid settings. You can also create a technician password to protect the grid configurations',
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Country selector button
                  InkWell(
                    onTap: _showCountryPicker,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Country',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            selectedCountry,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Set technician password button
                  InkWell(
                    onTap: () {
                      // Handle set technician password
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Set technician Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF016DB6),
                            ),
                          ),
                          const Spacer(),
                          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Spacer(),
                  // Continue button at bottom
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
                        'Continue',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
}
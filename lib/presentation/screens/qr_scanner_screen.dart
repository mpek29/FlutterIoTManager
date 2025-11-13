import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'setup_steps_screen.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final MobileScannerController cameraController = MobileScannerController();
  bool isFlashOn = false;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
      cameraController.toggleTorch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    final scanWidth = screenWidth * 0.9;
    final scanHeight = scanWidth * 0.7;
    final scanTop = (screenHeight - scanHeight) / 4;
    
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final qrCode = capture.barcodes.first.rawValue;
              if (qrCode != null) {
                Navigator.pop(context, qrCode);
              }
            },
          ),
          CustomPaint(
            painter: ScannerOverlayPainter(),
            child: Container(),
          ),
          // Back button
          Positioned(
            top: 50,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
              iconSize: 28,
              color: Colors.white,
            ),
          ),
          // Text and flash toggle below rectangle
          Positioned(
            top: scanTop + scanHeight + 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Scan the QR code on the Reset Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Point the camera at the QR code.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                IconButton(
                  icon: Icon(
                    isFlashOn ? Icons.flash_on : Icons.flash_off,
                    size: 32,
                  ),
                  onPressed: toggleFlash,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  'Connecting...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                // Temporary button to simulate QR scan
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetupStepsScreen(),
                      ),
                    );
                  },
                  child: Text('Simulate QR Scan (Temp)'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.6);

    // Define rectangle dimensions
    final scanWidth = size.width * 0.9;
    final scanHeight = scanWidth * 0.7; // Adjust ratio as needed
    final left = (size.width - scanWidth) / 2;
    final top = (size.height - scanHeight) / 4;
    final scanRect = Rect.fromLTWH(left, top, scanWidth, scanHeight);

    // Create path with hole in the middle
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(
        scanRect,
        const Radius.circular(0),
      ))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


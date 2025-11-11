import 'package:flutter/material.dart';
import 'data/repositories/device_repository.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

/// Root application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AppInitializer(),
    );
  }
}

/// Widget that determines which screen to show based on device availability
class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  final DeviceRepository _deviceRepository = DeviceRepository();
  bool _isLoading = true;
  bool _hasDevices = false;

  @override
  void initState() {
    super.initState();
    _checkDevices();
  }

  Future<void> _checkDevices() async {
    final hasDevices = await _deviceRepository.hasDevices();
    setState(() {
      _hasDevices = hasDevices;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _hasDevices ? const HomeScreen() : const WelcomeScreen();
  }
}

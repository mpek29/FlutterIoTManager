import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/device.dart';

/// Service class to manage device data from JSON file
class DeviceRepository {
  static const String _devicesJsonPath = 'assets/data/devices.json';

  /// Load devices from JSON file
  Future<List<Device>> loadDevices() async {
    try {
      final String jsonString = await rootBundle.loadString(_devicesJsonPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> devicesJson = jsonData['devices'] as List<dynamic>;

      return devicesJson
          .map((deviceJson) => Device.fromJson(deviceJson as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // If error loading, return empty list
      return [];
    }
  }

  /// Check if any devices exist
  Future<bool> hasDevices() async {
    final devices = await loadDevices();
    return devices.isNotEmpty;
  }

  /// Get device count
  Future<int> getDeviceCount() async {
    final devices = await loadDevices();
    return devices.length;
  }
}

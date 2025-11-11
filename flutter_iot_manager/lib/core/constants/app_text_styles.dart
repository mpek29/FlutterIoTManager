import 'package:flutter/material.dart';

/// Application text style constants
class AppTextStyles {
  AppTextStyles._();

  // Header styles
  static const TextStyle headerTitle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle pageTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  // Status styles
  static const TextStyle chargingStatus = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle statusSubtext = TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );

  // Data styles
  static const TextStyle dataLabel = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  static const TextStyle dataValue = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  // Button styles
  static const TextStyle buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  // Mode selector styles
  static const TextStyle modeTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle modeDescription = TextStyle(
    fontSize: 12,
    color: Colors.grey,
  );

  // Device card styles
  static const TextStyle deviceName = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle deviceStatus = TextStyle(
    fontSize: 14,
  );

  // Navigation bar styles
  static const TextStyle navLabel = TextStyle(
    fontSize: 14,
  );
}

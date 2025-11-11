import 'package:flutter/foundation.dart';

/// Represents a charging device
@immutable
class Device {
  final String id;
  final String name;
  final bool isOnline;
  final String status;
  final String? serialNumber;

  const Device({
    required this.id,
    required this.name,
    required this.isOnline,
    required this.status,
    this.serialNumber,
  });

  /// Create Device from JSON
  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'] as String,
      name: json['name'] as String,
      isOnline: json['isOnline'] as bool,
      status: json['status'] as String,
      serialNumber: json['serialNumber'] as String?,
    );
  }

  /// Convert Device to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isOnline': isOnline,
      'status': status,
      'serialNumber': serialNumber,
    };
  }

  Device copyWith({
    String? id,
    String? name,
    bool? isOnline,
    String? status,
    String? serialNumber,
  }) {
    return Device(
      id: id ?? this.id,
      name: name ?? this.name,
      isOnline: isOnline ?? this.isOnline,
      status: status ?? this.status,
      serialNumber: serialNumber ?? this.serialNumber,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Device &&
        other.id == id &&
        other.name == name &&
        other.isOnline == isOnline &&
        other.status == status &&
        other.serialNumber == serialNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^ 
        name.hashCode ^ 
        isOnline.hashCode ^ 
        status.hashCode ^
        serialNumber.hashCode;
  }
}

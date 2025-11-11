/// Enum representing charging modes
enum ChargingMode {
  eco,
  basic,
  dailyTrip;

  String get displayName {
    switch (this) {
      case ChargingMode.eco:
        return 'Eco';
      case ChargingMode.basic:
        return 'Basic';
      case ChargingMode.dailyTrip:
        return 'Daily Trip';
    }
  }
}

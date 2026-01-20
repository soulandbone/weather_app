import 'package:weather_app/enums/pressure_units.dart';
import 'package:weather_app/enums/wind_units.dart';

class UnitsMapper {
  int intFromPressureUnits(PressureUnits units) {
    switch (units) {
      case PressureUnits.hectopascals:
        return 1;
      case PressureUnits.inchesOfMercury:
        return 2;
      case PressureUnits.millimetersOfMercury:
        return 3;
    }
  }

  PressureUnits pressureUnitsFromInt(int number) {
    switch (number) {
      case 1:
        return PressureUnits.hectopascals;
      case 2:
        return PressureUnits.inchesOfMercury;
      case 3:
        return PressureUnits.millimetersOfMercury;
      default:
        return PressureUnits.hectopascals;
    }
  }

  int intFromWindUnits(WindUnits units) {
    switch (units) {
      case WindUnits.kilometersPerHour:
        return 1;
      case WindUnits.metersPerSecond:
        return 2;
      case WindUnits.milesPerHour:
        return 3;
      case WindUnits.feetPerSecond:
        return 4;
      case WindUnits.nauticalMilesPerHour:
        return 5;
    }
  }

  WindUnits windUnitsFromInt(int number) {
    switch (number) {
      case 1:
        return WindUnits.kilometersPerHour;
      case 2:
        return WindUnits.metersPerSecond;
      case 3:
        return WindUnits.milesPerHour;
      case 4:
        return WindUnits.feetPerSecond;
      case 5:
        return WindUnits.nauticalMilesPerHour;
      default:
        return WindUnits.kilometersPerHour;
    }
  }
}

import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/cubits/settings_state.dart';

class Utils {
  static String getTemperatureString(TemperatureUnits temperature) {
    switch (temperature) {
      case TemperatureUnits.celsius:
        return AppStrings.kCelsius;
      case TemperatureUnits.fahrenheit:
        return AppStrings.kFahrenheit;
    }
  }

  static String getWindString(WindUnits wind) {
    switch (wind) {
      case WindUnits.feetPerSecond:
        return AppStrings.kFeetPerSecond;
      case WindUnits.kilometersPerHour:
        return AppStrings.kKilometersPerHour;
      case WindUnits.metersPerSecond:
        return AppStrings.kMetersPerSecond;
      case WindUnits.milesPerHour:
        return AppStrings.kMilesPerHour;
      case WindUnits.nauticalMilesPerHour:
        return AppStrings.kNauticalMilesPerHour;
    }
  }

  static TemperatureUnits getTemperatureEnum(String temperature) {
    switch (temperature) {
      case AppStrings.kCelsius:
        return TemperatureUnits.celsius;
      case AppStrings.kFahrenheit:
        return TemperatureUnits.fahrenheit;
      default:
        throw ArgumentError('Unknown temperature argument $temperature');
    }
  }

  static WindUnits getWindEnum(String wind) {
    switch (wind) {
      case AppStrings.kMetersPerSecond:
        return WindUnits.metersPerSecond;
      case AppStrings.kKilometersPerHour:
        return WindUnits.kilometersPerHour;
      case AppStrings.kFeetPerSecond:
        return WindUnits.feetPerSecond;
      case AppStrings.kMilesPerHour:
        return WindUnits.milesPerHour;
      case AppStrings.kNauticalMilesPerHour:
        return WindUnits.nauticalMilesPerHour;
      default:
        throw ArgumentError('Unknown wind argument $wind');
    }
  }
}

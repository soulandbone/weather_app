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

  static TemperatureUnits getTemperatureEnum(String temperature) {
    switch (temperature) {
      case AppStrings.kCelsius:
        return TemperatureUnits.celsius;
      case AppStrings.kFahrenheit:
        return TemperatureUnits.fahrenheit;
    }
    return TemperatureUnits.fahrenheit;
  }
}

import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/enums/pressure_units.dart';
import 'package:weather_app/enums/temperature_units.dart';
import 'package:weather_app/enums/wind_units.dart';

class AppMaps {
  static Map<TemperatureUnits, String> temperatureMappings = {
    TemperatureUnits.celsius: AppStrings.kCelsius,
    TemperatureUnits.fahrenheit: AppStrings.kFahrenheit,
  };

  static Map<PressureUnits, String> pressureOptions = {};

  static Map<WindUnits, String> windOptions = {};
}

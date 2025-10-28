import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/enums/precipitation_units.dart';
import 'package:weather_app/enums/pressure_units.dart';
import 'package:weather_app/enums/temperature_units.dart';
import 'package:weather_app/enums/visibility_units.dart';
import 'package:weather_app/enums/wind_units.dart';

class AppMaps {
  static Map<TemperatureUnits, String> kTemperatureMappings = {
    TemperatureUnits.celsius: AppStrings.kCelsius,
    TemperatureUnits.fahrenheit: AppStrings.kFahrenheit,
  };

  static Map<PressureUnits, String> kPressureMappings = {
    PressureUnits.hectopascals: AppStrings.kHectopascals,
    PressureUnits.millimetersOfMercury: AppStrings.kMillimetersOfMercury,
    PressureUnits.inchesOfMercury: AppStrings.kInchesOfMercury,
  };

  static Map<WindUnits, String> kWindMappings = {
    WindUnits.kilometersPerHour: AppStrings.kKilometersPerHour,
    WindUnits.metersPerSecond: AppStrings.kMetersPerSecond,
    WindUnits.feetPerSecond: AppStrings.kFeetPerSecond,
    WindUnits.milesPerHour: AppStrings.kMilesPerHour,
    WindUnits.nauticalMilesPerHour: AppStrings.kNauticalMilesPerHour,
  };

  static Map<PrecipitationUnits, String> kPrecipitationMappings = {
    PrecipitationUnits.millimeters: AppStrings.kMillimeters,
    PrecipitationUnits.inches: AppStrings.kInches,
  };

  static Map<VisibilityUnits, String> kVisibilityMappings = {
    VisibilityUnits.kilometers: AppStrings.kKilometers,
    VisibilityUnits.miles: AppStrings.kMiles,
  };
}

import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/enums/temperature_units.dart';

class AppLists {
  static const List<TemperatureUnits> temperatureOptions = [
    TemperatureUnits.celsius,
    TemperatureUnits.fahrenheit,
  ];

  static const List<String> windOptions = [
    AppStrings.kMetersPerSecond,
    AppStrings.kKilometersPerHour,
    AppStrings.kFeetPerSecond,
    AppStrings.kMilesPerHour,
    AppStrings.kNauticalMilesPerHour,
  ];

  static const List<String> precipitationOptions = [
    AppStrings.kMillimeters,
    AppStrings.kInches,
  ];

  static const List<String> pressureOptions = [
    AppStrings.kHectopascals,
    AppStrings.kMillimetersOfMercury,
    AppStrings.kInchesOfMercury,
  ];

  static const List<String> visibilityOptions = [
    AppStrings.kKilometers,
    AppStrings.kMiles,
  ];
}

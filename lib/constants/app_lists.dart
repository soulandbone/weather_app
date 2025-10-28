import 'package:weather_app/enums/precipitation_units.dart';
import 'package:weather_app/enums/pressure_units.dart';
import 'package:weather_app/enums/temperature_units.dart';
import 'package:weather_app/enums/visibility_units.dart';
import 'package:weather_app/enums/wind_units.dart';

class AppLists {
  static const List<TemperatureUnits> kTemperatureOptions = [
    TemperatureUnits.celsius,
    TemperatureUnits.fahrenheit,
  ];

  static const List<WindUnits> kWindOptions = [
    WindUnits.kilometersPerHour,
    WindUnits.metersPerSecond,
    WindUnits.milesPerHour,
    WindUnits.feetPerSecond,
    WindUnits.nauticalMilesPerHour,
  ];

  static const List<PrecipitationUnits> kPrecipitationOptions = [
    PrecipitationUnits.millimeters,
    PrecipitationUnits.inches,
  ];

  static const List<PressureUnits> kPressureOptions = [
    PressureUnits.hectopascals,
    PressureUnits.millimetersOfMercury,
    PressureUnits.inchesOfMercury,
  ];

  static const List<VisibilityUnits> kVisibilityOptions = [
    VisibilityUnits.kilometers,
    VisibilityUnits.miles,
  ];
}

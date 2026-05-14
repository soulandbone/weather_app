import 'package:weather_app/enums/precipitation_units.dart';
import 'package:weather_app/enums/pressure_units.dart';
import 'package:weather_app/enums/temperature_units.dart';
import 'package:weather_app/enums/visibility_units.dart';
import 'package:weather_app/enums/wind_units.dart';

class SettingsState {
  SettingsState();
}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  SettingsLoaded({
    required this.temperature,
    required this.precipitation,
    required this.visibility,
    required this.pressure,
    required this.wind,
  });

  TemperatureUnits temperature;
  PrecipitationUnits precipitation;
  VisibilityUnits visibility;
  PressureUnits pressure;
  WindUnits wind;

  SettingsLoaded copyWith({
    TemperatureUnits? temperature,
    PrecipitationUnits? precipitation,
    VisibilityUnits? visibility,
    PressureUnits? pressure,
    WindUnits? wind,
  }) {
    return SettingsLoaded(
      temperature: temperature ?? this.temperature,
      precipitation: precipitation ?? this.precipitation,
      visibility: visibility ?? this.visibility,
      pressure: pressure ?? this.pressure,
      wind: wind ?? this.wind,
    );
  }
}

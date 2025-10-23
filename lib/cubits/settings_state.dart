enum WindUnits {
  metersPerSecond,
  kilometersPerHour,
  feetPerSecond,
  milesPerHour,
  nauticalMilesPerHour,
}

enum PressureUnits { hectopascals, millimetersOfMercury, inchesOfMercury }

enum TemperatureUnits { celsius, fahrenheit }

enum PrecipitationUnits { millimeters, inches }

enum VisibilityUnits { kilometers, miles }

class SettingsState {
  SettingsState({
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

  SettingsState copyWith({
    TemperatureUnits? temperature,
    PrecipitationUnits? precipitation,
    VisibilityUnits? visibility,
    PressureUnits? pressure,
    WindUnits? wind,
  }) {
    return SettingsState(
      temperature: temperature ?? this.temperature,
      precipitation: precipitation ?? this.precipitation,
      visibility: visibility ?? this.visibility,
      pressure: pressure ?? this.pressure,
      wind: wind ?? this.wind,
    );
  }
}

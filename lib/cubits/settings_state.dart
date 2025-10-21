enum WindOptions {
  metersPerSecond,
  kilometersPerHour,
  feetPerSecond,
  milesPerHour,
  nauticalMilesPerHour,
}

enum Pressure { hectopascals, millimetersOfMercury, inchesOfMercury }

class SettingsState {
  SettingsState({
    required this.isTempCelsius,
    required this.isPrecipitationMillimeters,
    required this.isVisibilityKilometers,
    required this.pressure,
    required this.windOptions,
  });

  bool isTempCelsius;
  bool isPrecipitationMillimeters;
  bool isVisibilityKilometers;
  Pressure pressure;
  WindOptions windOptions;

  SettingsState copyWith({
    bool? isTempCelsius,
    bool? isPrecipitationMillimeters,
    bool? isVisibilityKilometers,
    Pressure? pressure,
    WindOptions? windOptions,
  }) {
    return SettingsState(
      isTempCelsius: isTempCelsius ?? this.isTempCelsius,
      isPrecipitationMillimeters:
          isPrecipitationMillimeters ?? this.isPrecipitationMillimeters,
      isVisibilityKilometers:
          isVisibilityKilometers ?? this.isVisibilityKilometers,
      pressure: pressure ?? this.pressure,
      windOptions: windOptions ?? this.windOptions,
    );
  }
}

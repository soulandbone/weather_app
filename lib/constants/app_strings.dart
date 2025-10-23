class AppStrings {
  /*------------------Temperature---------------- */
  static const String kTemperatureLabel = 'Temperature';
  static const String kCelsius = 'Celsius - °C';
  static const String kFahrenheit = 'Fahrenheit - °F';

  /*------------------Wind---------------- */
  static const String kWindLabel = 'Wind';
  static const String kMetersPerSecond = "Meters per second - m/s";
  static const String kKilometersPerHour = "Kilometers per hour - km/h";
  static const String kFeetPerSecond = "Feet per second - ft/s";
  static const String kMilesPerHour = "Miles per hour - mph";
  static const String kNauticalMilesPerHour = "Nautical miles per hour - kts";

  /*------------------Wind---------------- */
  static const String kPressureLabel = 'Pressure';
}

class AppLists {
  static const List<String> temperatureOptions = [
    AppStrings.kCelsius,
    AppStrings.kFahrenheit,
  ];

  static const List<String> windOptions = [
    AppStrings.kMetersPerSecond,
    AppStrings.kKilometersPerHour,
    AppStrings.kFeetPerSecond,
    AppStrings.kMilesPerHour,
    AppStrings.kNauticalMilesPerHour,
  ];
}

import 'package:flutter/rendering.dart';

class AppStrings {
  static const String kCelsius = 'Celsius - °C';
  static const String kFahrenheit = 'Fahrenheit - °F';
  static const String kWindLabel = 'Wind';
  static const String kPressureLabel = 'Pressure';
  static const String kTemperatureLabel = 'Temperature';
}

class AppLists {
  static const List<String> temperatureOptions = [
    AppStrings.kCelsius,
    AppStrings.kFahrenheit,
  ];
}

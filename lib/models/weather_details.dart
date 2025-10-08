import 'package:flutter/material.dart';

class WeatherDetails {
  WeatherDetails({
    required this.temperature,
    required this.time,
    required this.icon,
  });

  final String temperature;
  final String time;
  final IconData icon;
}

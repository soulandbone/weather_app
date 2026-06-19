import 'dart:convert';

import 'package:weather_app/core/exceptions.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/services/api_service.dart';

abstract class WeatherRepository {
  Future<WeatherResponse> getWeatherData(String city, String country);
  Future<ThreeDaysForecast> getThreeDaysForecast(String city, String country);
}

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(this.apiService);

  final ApiService apiService;

  ThreeDaysForecast? _cachedThreeDays;

  ThreeDaysForecast? get cachedThreeDays => _cachedThreeDays;

  Future<T> _fetchAndParse<T>(
    String city,
    String country,
    int days,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      var weatherInfo = await apiService.fetchData(
        city: city,
        country: country,
        days: days,
      );

      var decodedJson = jsonDecode(weatherInfo.body) as Map<String, dynamic>;

      return fromJson(decodedJson);
    } on FormatException catch (e) {
      throw ParseException('Invalid format : {$e.message}');
    }
  }

  @override
  Future<WeatherResponse> getWeatherData(String city, String country) async {
    return _fetchAndParse(city, country, 1, WeatherResponse.fromJson);
  }

  @override
  Future<ThreeDaysForecast> getThreeDaysForecast(
    String city,
    String country,
  ) async {
    return _fetchAndParse(city, country, 3, ThreeDaysForecast.fromJson);
  }
}

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

  @override
  Future<WeatherResponse> getWeatherData(String city, String country) async {
    var weatherInfo = await apiService.fetchData(city, country);

    return WeatherResponse.fromJson(weatherInfo);
  }

  @override
  Future<ThreeDaysForecast> getThreeDaysForecast(
    String city,
    String country,
  ) async {
    var weatherInfo = await apiService.fetchData(city, country, days: 3);

    final forecast = ThreeDaysForecast.fromJson(weatherInfo);

    _cachedThreeDays = forecast;

    return forecast;
  }
}

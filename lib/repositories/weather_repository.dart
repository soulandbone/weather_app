import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/services/api_service.dart';

abstract class WeatherRepository {
  Future<WeatherResponse> getWeatherData(String city, String country);
  Future<SevenDaysForecast> getSevenDaysForecast(String city, String country);
}

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(this.apiService);

  final ApiService apiService;

  @override
  Future<WeatherResponse> getWeatherData(String city, String country) async {
    var weatherInfo = await apiService.fetchData(city, country);

    return WeatherResponse.fromJson(weatherInfo);
  }

  @override
  Future<SevenDaysForecast> getSevenDaysForecast(
    String city,
    String country,
  ) async {
    var weatherInfo = await apiService.fetchData(city, country, days: 7);

    return SevenDaysForecast.fromJson(weatherInfo);
  }
}

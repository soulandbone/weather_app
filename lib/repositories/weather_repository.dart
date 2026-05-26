import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/services/api_service.dart';

abstract class WeatherRepository {
  Future<MainWeatherInfo> getWeatherData(String city, String country);
  Future<HourbyHourDetails> getWeatherHourByHourDetails(
    String city,
    String country,
  );
}

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(this.apiService);

  final ApiService apiService;

  @override
  Future<MainWeatherInfo> getWeatherData(String city, String country) async {
    var weatherInfo = await apiService.fetchData(city, country);

    return MainWeatherInfo.fromJson(weatherInfo);
  }

  @override
  Future<HourbyHourDetails> getWeatherHourByHourDetails(
    String city,
    String country,
  ) async {
    var weatherHourByHourDetails = await apiService.fetchData(city, country);

    return HourbyHourDetails.fromJson(weatherHourByHourDetails);
  }
}

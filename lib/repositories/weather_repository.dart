import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/services/api_service.dart';

abstract class WeatherRepository {
  Future<MainWeatherInfo> getWeatherData(String city);
  Future<HourbyHourDetails> getWeatherHourByHourDetails(String city);
}

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(this.apiService);

  final ApiService apiService;

  @override
  Future<MainWeatherInfo> getWeatherData(String city) async {
    var weatherInfo = await apiService.fetchData(city);

    return MainWeatherInfo.fromJson(weatherInfo);
  }

  @override
  Future<HourbyHourDetails> getWeatherHourByHourDetails(String city) async {
    var weatherHourByHourDetails = await apiService.fetchData(city);

    return HourbyHourDetails.fromJson(weatherHourByHourDetails);
  }
}

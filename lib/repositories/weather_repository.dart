import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/services/api_service.dart';

abstract class WeatherRepository {
  Future<MainWeatherInfo> getWeatherData(String city); //
}

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({required this.apiService});
  final ApiServiceImpl apiService;

  @override
  Future<MainWeatherInfo> getWeatherData(String city) async {
    var data = await apiService.getDataFromApi();
    return MainWeatherInfo.fromJson(data);
  }
}

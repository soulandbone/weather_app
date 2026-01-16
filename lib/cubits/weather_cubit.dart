import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_state.dart';
import 'package:weather_app/repositories/weather_repository.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.repository) : super(WeatherInitial());

  final WeatherRepository repository;

  Future<void> fetchWeatherInfo(String city) async {
    emit(WeatherLoading());
    try {
      var mainWeatherInfo = await repository.getWeatherData(city);
      var hourlyWeatherInfo = await repository.getWeatherHourByHourDetails(
        city, // Was set to 'Paris' before (check in case it breaks)
      );
      emit(
        WeatherLoaded(
          hourByHourDetails: hourlyWeatherInfo,
          mainWeatherInfo: mainWeatherInfo,
        ),
      );
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}

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
      emit(WeatherLoaded(mainWeatherInfo));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}

import 'package:weather_app/models/weather_models.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {
  //initial State, nothing has happened
}

class WeatherLoading extends WeatherState {
  //First state the moment we start fetching the data
}

class WeatherLoaded extends WeatherState {
  WeatherLoaded({
    required this.weatherResponse,
    this.isForecastLoading = true,
    this.forecastResponse,
  });

  final WeatherResponse weatherResponse;
  final ThreeDaysForecast? forecastResponse;
  final bool isForecastLoading;

  WeatherLoaded copyWith({
    WeatherResponse? weatherResponse,
    ThreeDaysForecast? forecastResponse,
    bool? isForecastLoading,
  }) {
    return WeatherLoaded(
      weatherResponse: weatherResponse ?? this.weatherResponse,
      forecastResponse: forecastResponse ?? this.forecastResponse,
      isForecastLoading: isForecastLoading ?? this.isForecastLoading,
    );
  }

  //State the moment we have loaded the data. It Returns the data
}

class WeatherError extends WeatherState {
  WeatherError(this.message);

  final String message;
  //State the moment an error occurs, it returns a message.
}

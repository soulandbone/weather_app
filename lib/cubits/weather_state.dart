import 'package:weather_app/models/weather_models.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {
  //initial State, nothing has happened
}

class WeatherLoading extends WeatherState {
  //First state the moment we start fetching the data
}

class WeatherLoaded extends WeatherState {
  WeatherLoaded(this.mainWeatherInfo);

  final MainWeatherInfo mainWeatherInfo;
  //State the moment we have loaded the data. It Returns the data
}

class WeatherError extends WeatherState {
  WeatherError(this.message);

  final String message;
  //State the moment an error occurs, it returns a message.
}
